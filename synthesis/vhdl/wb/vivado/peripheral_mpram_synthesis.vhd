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
--              Master Slave Interface Tesbench                               --
--              AMBA4 AHB-Lite Bus Interface                                  --
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
--   Paco Reina Campo <pacoreinacampo@queenfield.tech>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.peripheral_mpram_wb_pkg.all;

entity peripheral_mpram_synthesis is
  generic (
    -- Memory Parameters
    DEPTH   : integer := 256;
    MEMFILE : string  := "";
    -- WishBone Parameters
    DW      : integer := 32;
    AW      : integer := integer(log2(real(DEPTH)))
  );
  port (
    wb_clk_i : in std_logic;
    wb_rst_i : in std_logic;

    wb_adr_i : in std_logic_vector(AW-1 downto 0);
    wb_dat_i : in std_logic_vector(DW-1 downto 0);
    wb_sel_i : in std_logic_vector(3 downto 0);
    wb_we_i  : in std_logic;
    wb_bte_i : in std_logic_vector(1 downto 0);
    wb_cti_i : in std_logic_vector(2 downto 0);
    wb_cyc_i : in std_logic;
    wb_stb_i : in std_logic;

    wb_ack_o : out std_logic;
    wb_err_o : out std_logic;
    wb_dat_o : out std_logic_vector(DW-1 downto 0)
    );
end peripheral_mpram_synthesis;

architecture rtl of peripheral_mpram_synthesis is

  ------------------------------------------------------------------------------
  -- Components
  ------------------------------------------------------------------------------

  component peripheral_mpram_wb
    generic (
      -- Memory Parameters
      DEPTH   : integer := 256;
      MEMFILE : string  := "";
      -- WishBone Parameters
      DW      : integer := 32;
      AW      : integer := integer(log2(real(DEPTH)))
    );
    port (
      wb_clk_i : in std_logic;
      wb_rst_i : in std_logic;

      wb_adr_i : in std_logic_vector(AW-1 downto 0);
      wb_dat_i : in std_logic_vector(DW-1 downto 0);
      wb_sel_i : in std_logic_vector(3 downto 0);
      wb_we_i  : in std_logic;
      wb_bte_i : in std_logic_vector(1 downto 0);
      wb_cti_i : in std_logic_vector(2 downto 0);
      wb_cyc_i : in std_logic;
      wb_stb_i : in std_logic;

      wb_ack_o : out std_logic;
      wb_err_o : out std_logic;
      wb_dat_o : out std_logic_vector(DW-1 downto 0)
    );
  end component;

begin

  ------------------------------------------------------------------------------
  -- Module Body
  ------------------------------------------------------------------------------

  -- DUT WB
  mpram_wb : peripheral_mpram_wb
    generic map (
      DEPTH   => DEPTH,
      MEMFILE => MEMFILE,

      AW => AW,
      DW => DW
      )
    port map (
      wb_clk_i => wb_clk_i,
      wb_rst_i => wb_rst_i,

      wb_adr_i => wb_adr_i,
      wb_dat_i => wb_dat_i,
      wb_sel_i => wb_sel_i,
      wb_we_i  => wb_we_i,
      wb_bte_i => wb_bte_i,
      wb_cti_i => wb_cti_i,
      wb_cyc_i => wb_cyc_i,
      wb_stb_i => wb_stb_i,
      wb_ack_o => wb_ack_o,
      wb_err_o => wb_err_o,
      wb_dat_o => wb_dat_o
      );
end rtl;
