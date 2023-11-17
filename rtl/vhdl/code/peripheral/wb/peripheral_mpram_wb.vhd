--------------------------------------------------------------------------------
--                                            __ _      _     _               --
--                                           / _(_)    | |   | |              --
--                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              --
--               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              --
--              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              --
--               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              --
--                  | |                                                       --
--                  |_|                                                       --
--                                                                            --
--                                                                            --
--              MPSoC-RISCV CPU                                               --
--              Single Port RAM                                               --
--              Wishbone Bus Interface                                        --
--                                                                            --
--------------------------------------------------------------------------------

-- Copyright (c) 2018-2019 by the author(s)
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
--------------------------------------------------------------------------------
-- Author(s):
--   Olof Kindgren <olof.kindgren@gmail.com>
--   Paco Reina Campo <pacoreinacampo@queenfield.tech>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.vhdl_pkg.all;
use work.peripheral_wb_pkg.all;

entity peripheral_mpram_wb is
  generic (
    -- Memory parameters
    DEPTH   : integer := 256;
    MEMFILE : string  := "";

    -- Wishbone parameters
    AW : integer := integer(log2(real(DEPTH)));
    DW : integer := 32;

    CORES_PER_TILE : integer := 8
    );
  port (
    wb_clk_i : in std_logic;
    wb_rst_i : in std_logic;

    wb_adr_i : in std_logic_matrix(CORES_PER_TILE-1 downto 0)(AW-1 downto 0);
    wb_dat_i : in std_logic_matrix(CORES_PER_TILE-1 downto 0)(DW-1 downto 0);
    wb_sel_i : in std_logic_matrix(CORES_PER_TILE-1 downto 0)(3 downto 0);
    wb_we_i  : in std_logic_vector(CORES_PER_TILE-1 downto 0);
    wb_bte_i : in std_logic_matrix(CORES_PER_TILE-1 downto 0)(1 downto 0);
    wb_cti_i : in std_logic_matrix(CORES_PER_TILE-1 downto 0)(2 downto 0);
    wb_cyc_i : in std_logic_vector(CORES_PER_TILE-1 downto 0);
    wb_stb_i : in std_logic_vector(CORES_PER_TILE-1 downto 0);

    wb_ack_o : out std_logic_vector(CORES_PER_TILE-1 downto 0);
    wb_err_o : out std_logic_vector(CORES_PER_TILE-1 downto 0);
    wb_dat_o : out std_logic_matrix(CORES_PER_TILE-1 downto 0)(DW-1 downto 0)
    );
end peripheral_mpram_wb;

architecture rtl of peripheral_mpram_wb is

  ------------------------------------------------------------------------------
  -- Components
  ------------------------------------------------------------------------------

  component peripheral_mpram_generic_wb
    generic (
      DEPTH   : integer := 256;
      MEMFILE : string  := "";

      AW : integer := integer(log2(real(DEPTH)));
      DW : integer := 32
      );
    port (
      clk   : in  std_logic;
      we    : in  std_logic_vector(3 downto 0);
      din   : in  std_logic_vector(DW-1 downto 0);
      waddr : in  std_logic_vector(AW-1 downto 0);
      raddr : in  std_logic_vector(AW-1 downto 0);
      dout  : out std_logic_vector(DW-1 downto 0)
      );
  end component;

  ------------------------------------------------------------------------------
  -- Constants
  ------------------------------------------------------------------------------
  constant CLASSIC_CYCLE : std_logic := '0';
  constant BURST_CYCLE   : std_logic := '1';

  constant READ  : std_logic := '0';
  constant WRITE : std_logic := '1';

  constant CTI_CLASSIC      : std_logic_vector(2 downto 0) := "000";
  constant CTI_CONST_BURST  : std_logic_vector(2 downto 0) := "001";
  constant CTI_INC_BURST    : std_logic_vector(2 downto 0) := "010";
  constant CTI_END_OF_BURST : std_logic_vector(2 downto 0) := "111";

  constant BTE_LINEAR  : std_logic_vector(1 downto 0) := "00";
  constant BTE_WRAP_4  : std_logic_vector(1 downto 0) := "01";
  constant BTE_WRAP_8  : std_logic_vector(1 downto 0) := "10";
  constant BTE_WRAP_16 : std_logic_vector(1 downto 0) := "11";

  ------------------------------------------------------------------------------
  -- Functions
  ------------------------------------------------------------------------------
  function get_cycle_type (
    cti : std_logic_vector(2 downto 0)
    ) return std_logic is

    variable get_cycle_type_return : std_logic;
  begin
    if (cti = CTI_CLASSIC) then
      get_cycle_type_return := CLASSIC_CYCLE;
    else
      get_cycle_type_return := BURST_CYCLE;
    end if;
    return get_cycle_type_return;
  end get_cycle_type;

  function wb_is_last (
    cti : std_logic_vector(2 downto 0)
    ) return std_logic is

    variable wb_is_last_return : std_logic;
  begin
    case ((cti)) is
      when CTI_CLASSIC =>
        wb_is_last_return := '1';
      when CTI_CONST_BURST =>
        wb_is_last_return := '0';
      when CTI_INC_BURST =>
        wb_is_last_return := '0';
      when CTI_END_OF_BURST =>
        wb_is_last_return := '1';
      when others =>
        null;
    end case;
    return wb_is_last_return;
  end wb_is_last;

  function wb_next_adr (
    adr_i : std_logic_vector(AW-1 downto 0);
    cti_i : std_logic_vector(2 downto 0);
    bte_i : std_logic_vector(1 downto 0)

    ) return std_logic_vector is

    variable adr : std_logic_vector(AW-1 downto 0);

    variable shift : integer;

    variable wb_next_adr_return : std_logic_vector (AW-1 downto 0);
  begin
    if (DW = 64) then
      shift := 3;
    elsif (DW = 32) then
      shift := 2;
    elsif (DW = 16) then
      shift := 1;
    else
      shift := 0;
    end if;
    adr := std_logic_vector(unsigned(adr_i) srl shift);
    if (cti_i = CTI_INC_BURST) then
      case ((bte_i)) is
        when BTE_LINEAR =>
          adr := std_logic_vector(unsigned(adr)+X"00000001");
        when BTE_WRAP_4 =>
          adr := adr(31 downto 2) & std_logic_vector(unsigned(adr(1 downto 0))+"01");
        when BTE_WRAP_8 =>
          adr := adr(31 downto 3) & std_logic_vector(unsigned(adr(2 downto 0))+"001");
        when BTE_WRAP_16 =>
          adr := adr(31 downto 4) & std_logic_vector(unsigned(adr(3 downto 0))+"0001");
        when others =>
          null;
      end case;
    end if;
    -- case (burst_type_i)
    wb_next_adr_return := std_logic_vector(unsigned(adr) sll shift);
    return wb_next_adr_return;
  end wb_next_adr;

--////////////////////////////////////////////////////////////////
--
-- Variables
--
  signal adr_r     : std_logic_matrix(CORES_PER_TILE-1 downto 0)(AW-1 downto 0);
  signal next_adr  : std_logic_matrix(CORES_PER_TILE-1 downto 0)(AW-1 downto 0);
  signal valid     : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal valid_r   : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal is_last_r : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal new_cycle : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal adr       : std_logic_matrix(CORES_PER_TILE-1 downto 0)(AW-1 downto 0);
  signal ram_we    : std_logic_vector(CORES_PER_TILE-1 downto 0);

  signal wb_ack : std_logic_vector(CORES_PER_TILE-1 downto 0);

  signal we_i : std_logic_matrix(CORES_PER_TILE-1 downto 0)(3 downto 0);

begin
  ------------------------------------------------------------------------------
  -- Module Body
  ------------------------------------------------------------------------------
  generating_0 : for t in 0 to CORES_PER_TILE - 1 generate
    valid(t) <= wb_cyc_i(t) and wb_stb_i(t);

    processing_0 : process (wb_clk_i)
    begin
      if (rising_edge(wb_clk_i)) then
        is_last_r(t) <= wb_is_last(wb_cti_i(t));
      end if;
    end process;

    new_cycle(t) <= (valid(t) and not valid_r(t)) or is_last_r(t);

    next_adr(t) <= wb_next_adr(adr_r(t), wb_cti_i(t), wb_bte_i(t));

    adr(t) <= wb_adr_i(t) when new_cycle(t) = '1' else next_adr(t);

    processing_1 : process (wb_clk_i)
    begin
      if (rising_edge(wb_clk_i)) then
        adr_r(t)   <= adr(t);
        valid_r(t) <= valid(t);
        -- Ack generation
        wb_ack(t)  <= valid(t) and (not (to_stdlogic(wb_cti_i(t) = "000") or to_stdlogic(wb_cti_i(t) = "111")) or not wb_ack(t));
        if (wb_rst_i = '1') then
          adr_r(t)   <= (others => '0');
          valid_r(t) <= '0';
          wb_ack(t)  <= '0';
        end if;
      end if;
    end process;

    ram_we(t) <= wb_we_i(t) and valid(t) and wb_ack(t);

    wb_ack_o(t) <= wb_ack(t);

    -- TO-DO:ck for burst address errors
    wb_err_o(t) <= '0';

    ram0 : peripheral_mpram_generic_wb
      generic map (
        DEPTH   => DEPTH/4,
        MEMFILE => MEMFILE,

        AW => integer(log2(real(DEPTH/4))),
        DW => DW
        )
      port map (
        clk   => wb_clk_i,
        we    => we_i(t),
        din   => wb_dat_i(t),
        waddr => adr_r(t)(AW-1 downto 2),
        raddr => adr(t)(AW-1 downto 2),
        dout  => wb_dat_o(t)
        );

    we_i(t) <= (ram_we(t) & ram_we(t) & ram_we(t) & ram_we(t)) and wb_sel_i(t);
  end generate;
end rtl;
