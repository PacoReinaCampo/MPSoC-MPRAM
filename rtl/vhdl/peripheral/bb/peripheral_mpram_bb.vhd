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
--              MSP430 CPU                                                    --
--              Processing Unit                                               --
--                                                                            --
--------------------------------------------------------------------------------

-- Copyright (c) 2015-2016 by the author(s)
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
--   Olivier Girard <olgirard@gmail.com>
--   Paco Reina Campo <pacoreinacampo@queenfield.tech>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.msp430_pkg.all;

entity peripheral_mpram_bb is
  generic (
    ADDR_MSB : integer := 6;                       -- MSB of the address bus
    MEM_SIZE : integer := 256);                    -- Memory size in bytes
  port (
    -- OUTPUTs
    ram_dout : out std_logic_vector(15 downto 0);  -- RAM data output

    -- INPUTs
    ram_addr : in std_logic_vector(ADDR_MSB downto 0);  -- RAM address
    ram_cen  : in std_logic;            -- RAM chip enable (low active)
    ram_clk  : in std_logic;            -- RAM clock
    ram_din  : in std_logic_vector(15 downto 0);  -- RAM data input
    ram_wen  : in std_logic_vector(1 downto 0));  -- RAM write enable (low active)    
end peripheral_mpram_bb;

architecture rtl of peripheral_mpram_bb is

  signal mem          : std_logic_matrix((MEM_SIZE/2)-1 downto 0)(15 downto 0);
  signal ram_addr_reg : std_logic_vector(ADDR_MSB downto 0);
  signal mem_val      : std_logic_vector(15 downto 0);

begin
  mem_val <= mem(to_integer(unsigned(ram_addr)));

  processing_0 : process (ram_clk)
  begin
    if (rising_edge(ram_clk)) then
      if (ram_cen = '0' and to_integer(unsigned(ram_addr)) < (MEM_SIZE/2)) then
        if (ram_wen = "00") then
          mem(to_integer(unsigned(ram_addr))) <= ram_din;
        elsif (ram_wen = "01") then
          mem(to_integer(unsigned(ram_addr))) <= (ram_din(15 downto 8) & mem_val(7 downto 0));
        elsif (ram_wen = "10") then
          mem(to_integer(unsigned(ram_addr))) <= (mem_val(15 downto 8) & ram_din(7 downto 0));
        end if;
        ram_addr_reg <= ram_addr;
      end if;
    end if;
  end process;

  ram_dout <= mem(to_integer(unsigned(ram_addr_reg)));
end rtl;
