-- Converted from bench/verilog/regression/mpsoc_mpram_testbench.sv
-- by verilog2vhdl - QueenField

--//////////////////////////////////////////////////////////////////////////////
--                                            __ _      _     _               //
--                                           / _(_)    | |   | |              //
--                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
--               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
--              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
--               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
--                  | |                                                       //
--                  |_|                                                       //
--                                                                            //
--                                                                            //
--              MPSoC-RISCV CPU                                               //
--              Master Slave Interface Tesbench                               //
--              AMBA3 AHB-Lite Bus Interface                                  //
--                                                                            //
--//////////////////////////////////////////////////////////////////////////////

-- Copyright (c) 2018-2019 by the author(s)
-- *
-- * Permission is hereby granted, free of charge, to any person obtaining a copy
-- * of this software and associated documentation files (the "Software"), to deal
-- * in the Software without restriction, including without limitation the rights
-- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- * copies of the Software, and to permit persons to whom the Software is
-- * furnished to do so, subject to the following conditions:
-- *
-- * The above copyright notice and this permission notice shall be included in
-- * all copies or substantial portions of the Software.
-- *
-- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- * THE SOFTWARE.
-- *
-- * =============================================================================
-- * Author(s):
-- *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
-- */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.mpsoc_mpram_ahb3_pkg.all;

entity mpsoc_mpram_testbench is
end mpsoc_mpram_testbench;

architecture RTL of mpsoc_mpram_testbench is

  --////////////////////////////////////////////////////////////////
  --
  -- Constants
  --
  constant CORES_PER_TILE : integer := 8;

  --////////////////////////////////////////////////////////////////
  --
  -- Variables
  --

  --Common signals
  signal HRESETn : std_logic;
  signal HCLK    : std_logic;

  --AHB3 signals
  signal mst_mpram_HSEL      : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal mst_mpram_HADDR     : std_logic_matrix(CORES_PER_TILE-1 downto 0)(PLEN-1 downto 0);
  signal mst_mpram_HWDATA    : std_logic_matrix(CORES_PER_TILE-1 downto 0)(XLEN-1 downto 0);
  signal mst_mpram_HRDATA    : std_logic_matrix(CORES_PER_TILE-1 downto 0)(XLEN-1 downto 0);
  signal mst_mpram_HWRITE    : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal mst_mpram_HSIZE     : std_logic_matrix(CORES_PER_TILE-1 downto 0)(2 downto 0);
  signal mst_mpram_HBURST    : std_logic_matrix(CORES_PER_TILE-1 downto 0)(2 downto 0);
  signal mst_mpram_HPROT     : std_logic_matrix(CORES_PER_TILE-1 downto 0)(3 downto 0);
  signal mst_mpram_HTRANS    : std_logic_matrix(CORES_PER_TILE-1 downto 0)(1 downto 0);
  signal mst_mpram_HMASTLOCK : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal mst_mpram_HREADY    : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal mst_mpram_HREADYOUT : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal mst_mpram_HRESP     : std_logic_vector(CORES_PER_TILE-1 downto 0);

  --////////////////////////////////////////////////////////////////
  --
  -- Components
  --
  component mpsoc_ahb3_mpram
    generic (
      MEM_SIZE          : integer := 256;  --Memory in Bytes
      MEM_DEPTH         : integer := 256;  --Memory depth
      PLEN              : integer := 64;
      XLEN              : integer := 64;
      TECHNOLOGY        : string  := "GENERIC";
      REGISTERED_OUTPUT : string  := "NO";

      CORES_PER_TILE : integer := 8
      );
    port (
      HRESETn : in std_logic;
      HCLK    : in std_logic;

      --AHB Slave Interfaces (receive data from AHB Masters)
      --AHB Masters connect to these ports
      HSEL      : in  std_logic_vector(CORES_PER_TILE-1 downto 0);
      HADDR     : in  std_logic_matrix(CORES_PER_TILE-1 downto 0)(PLEN-1 downto 0);
      HWDATA    : in  std_logic_matrix(CORES_PER_TILE-1 downto 0)(XLEN-1 downto 0);
      HRDATA    : out std_logic_matrix(CORES_PER_TILE-1 downto 0)(XLEN-1 downto 0);
      HWRITE    : in  std_logic_vector(CORES_PER_TILE-1 downto 0);
      HSIZE     : in  std_logic_matrix(CORES_PER_TILE-1 downto 0)(2 downto 0);
      HBURST    : in  std_logic_matrix(CORES_PER_TILE-1 downto 0)(2 downto 0);
      HPROT     : in  std_logic_matrix(CORES_PER_TILE-1 downto 0)(3 downto 0);
      HTRANS    : in  std_logic_matrix(CORES_PER_TILE-1 downto 0)(1 downto 0);
      HMASTLOCK : in  std_logic_vector(CORES_PER_TILE-1 downto 0);
      HREADYOUT : out std_logic_vector(CORES_PER_TILE-1 downto 0);
      HREADY    : in  std_logic_vector(CORES_PER_TILE-1 downto 0);
      HRESP     : out std_logic_vector(CORES_PER_TILE-1 downto 0)
      );
  end component;

begin
  --////////////////////////////////////////////////////////////////
  --
  -- Module Body
  --

  --DUT AHB3
  ahb3_mpram : mpsoc_ahb3_mpram
    generic map (
      MEM_SIZE          => 256,
      MEM_DEPTH         => 256,
      PLEN              => PLEN,
      XLEN              => XLEN,
      TECHNOLOGY        => TECHNOLOGY,
      REGISTERED_OUTPUT => "NO",

      CORES_PER_TILE => CORES_PER_TILE
      )
    port map (
      HRESETn => HRESETn,
      HCLK    => HCLK,

      HSEL      => mst_mpram_HSEL,
      HADDR     => mst_mpram_HADDR,
      HWDATA    => mst_mpram_HWDATA,
      HRDATA    => mst_mpram_HRDATA,
      HWRITE    => mst_mpram_HWRITE,
      HSIZE     => mst_mpram_HSIZE,
      HBURST    => mst_mpram_HBURST,
      HPROT     => mst_mpram_HPROT,
      HTRANS    => mst_mpram_HTRANS,
      HMASTLOCK => mst_mpram_HMASTLOCK,
      HREADYOUT => mst_mpram_HREADYOUT,
      HREADY    => mst_mpram_HREADY,
      HRESP     => mst_mpram_HRESP
      );
end RTL;
