-- Converted from bench/verilog/regression/mpsoc_msi_testbench.sv
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
-- *   Francisco Javier Reina Campo <frareicam@gmail.com>
-- */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.mpsoc_pkg.all;

entity mpsoc_msi_testbench is
end mpsoc_msi_testbench;

architecture RTL of mpsoc_msi_testbench is

  --////////////////////////////////////////////////////////////////
  --
  -- Constants
  --
  constant DW      : integer := 32;
  constant DEPTH   : integer := 256;
  constant AW      : integer := integer(log2(real(DEPTH)));
  constant MEMFILE : string  := "";

  --////////////////////////////////////////////////////////////////
  --
  -- Variables
  --

  --Common signals
  signal HRESETn : std_logic;
  signal HCLK    : std_logic;

  --AHB3 signals
  signal mst_misd_mpram_HSEL      : std_logic_vector(CORES_PER_MISD-1 downto 0);
  signal mst_misd_mpram_HADDR     : M_CORES_PER_MISD_PLEN;
  signal mst_misd_mpram_HWDATA    : M_CORES_PER_MISD_XLEN;
  signal mst_misd_mpram_HRDATA    : M_CORES_PER_MISD_XLEN;
  signal mst_misd_mpram_HWRITE    : std_logic_vector(CORES_PER_MISD-1 downto 0);
  signal mst_misd_mpram_HSIZE     : M_CORES_PER_MISD_2;
  signal mst_misd_mpram_HBURST    : M_CORES_PER_MISD_2;
  signal mst_misd_mpram_HPROT     : M_CORES_PER_MISD_3;
  signal mst_misd_mpram_HTRANS    : M_CORES_PER_MISD_1;
  signal mst_misd_mpram_HMASTLOCK : std_logic_vector(CORES_PER_MISD-1 downto 0);
  signal mst_misd_mpram_HREADY    : std_logic_vector(CORES_PER_MISD-1 downto 0);
  signal mst_misd_mpram_HREADYOUT : std_logic_vector(CORES_PER_MISD-1 downto 0);
  signal mst_misd_mpram_HRESP     : std_logic_vector(CORES_PER_MISD-1 downto 0);

  signal mst_simd_mpram_HSEL      : std_logic_vector(CORES_PER_SIMD-1 downto 0);
  signal mst_simd_mpram_HADDR     : M_CORES_PER_SIMD_PLEN;
  signal mst_simd_mpram_HWDATA    : M_CORES_PER_SIMD_XLEN;
  signal mst_simd_mpram_HRDATA    : M_CORES_PER_SIMD_XLEN;
  signal mst_simd_mpram_HWRITE    : std_logic_vector(CORES_PER_SIMD-1 downto 0);
  signal mst_simd_mpram_HSIZE     : M_CORES_PER_SIMD_2;
  signal mst_simd_mpram_HBURST    : M_CORES_PER_SIMD_2;
  signal mst_simd_mpram_HPROT     : M_CORES_PER_SIMD_3;
  signal mst_simd_mpram_HTRANS    : M_CORES_PER_SIMD_1;
  signal mst_simd_mpram_HMASTLOCK : std_logic_vector(CORES_PER_SIMD-1 downto 0);
  signal mst_simd_mpram_HREADY    : std_logic_vector(CORES_PER_SIMD-1 downto 0);
  signal mst_simd_mpram_HREADYOUT : std_logic_vector(CORES_PER_SIMD-1 downto 0);
  signal mst_simd_mpram_HRESP     : std_logic_vector(CORES_PER_SIMD-1 downto 0);

  --WB signals
  signal mst_mpram_adr_i : M_CORES_PER_TILE_AW;
  signal mst_mpram_dat_i : M_CORES_PER_TILE_DW;
  signal mst_mpram_sel_i : M_CORES_PER_TILE_3;
  signal mst_mpram_we_i  : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal mst_mpram_bte_i : M_CORES_PER_TILE_1;
  signal mst_mpram_cti_i : M_CORES_PER_TILE_2;
  signal mst_mpram_cyc_i : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal mst_mpram_stb_i : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal mst_mpram_ack_o : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal mst_mpram_err_o : std_logic_vector(CORES_PER_TILE-1 downto 0);
  signal mst_mpram_dat_o : M_CORES_PER_TILE_DW;

  --////////////////////////////////////////////////////////////////
  --
  -- Components
  --
  component mpsoc_misd_ahb3_mpram
    generic (
      MEM_SIZE          : integer := 256;  --Memory in Bytes
      MEM_DEPTH         : integer := 256;  --Memory depth
      PLEN              : integer := 64;
      XLEN              : integer := 64;
      TECHNOLOGY        : string  := "GENERIC";
      REGISTERED_OUTPUT : string  := "NO"
      );
    port (
      HRESETn : in std_logic;
      HCLK    : in std_logic;

      --AHB Slave Interfaces (receive data from AHB Masters)
      --AHB Masters connect to these ports
      HSEL      : in  std_logic_vector(CORES_PER_MISD-1 downto 0);
      HADDR     : in  M_CORES_PER_MISD_PLEN;
      HWDATA    : in  M_CORES_PER_MISD_XLEN;
      HRDATA    : out M_CORES_PER_MISD_XLEN;
      HWRITE    : in  std_logic_vector(CORES_PER_MISD-1 downto 0);
      HSIZE     : in  M_CORES_PER_MISD_2;
      HBURST    : in  M_CORES_PER_MISD_2;
      HPROT     : in  M_CORES_PER_MISD_3;
      HTRANS    : in  M_CORES_PER_MISD_1;
      HMASTLOCK : in  std_logic_vector(CORES_PER_MISD-1 downto 0);
      HREADYOUT : out std_logic_vector(CORES_PER_MISD-1 downto 0);
      HREADY    : in  std_logic_vector(CORES_PER_MISD-1 downto 0);
      HRESP     : out std_logic_vector(CORES_PER_MISD-1 downto 0)
      );
  end component;

  component mpsoc_simd_ahb3_mpram
    generic (
      MEM_SIZE          : integer := 256;  --Memory in Bytes
      MEM_DEPTH         : integer := 256;  --Memory depth
      PLEN              : integer := 64;
      XLEN              : integer := 64;
      TECHNOLOGY        : string  := "GENERIC";
      REGISTERED_OUTPUT : string  := "NO"
      );
    port (
      HRESETn : in std_logic;
      HCLK    : in std_logic;

      --AHB Slave Interfaces (receive data from AHB Masters)
      --AHB Masters connect to these ports
      HSEL      : in  std_logic_vector(CORES_PER_SIMD-1 downto 0);
      HADDR     : in  M_CORES_PER_SIMD_PLEN;
      HWDATA    : in  M_CORES_PER_SIMD_XLEN;
      HRDATA    : out M_CORES_PER_SIMD_XLEN;
      HWRITE    : in  std_logic_vector(CORES_PER_SIMD-1 downto 0);
      HSIZE     : in  M_CORES_PER_SIMD_2;
      HBURST    : in  M_CORES_PER_SIMD_2;
      HPROT     : in  M_CORES_PER_SIMD_3;
      HTRANS    : in  M_CORES_PER_SIMD_1;
      HMASTLOCK : in  std_logic_vector(CORES_PER_SIMD-1 downto 0);
      HREADYOUT : out std_logic_vector(CORES_PER_SIMD-1 downto 0);
      HREADY    : in  std_logic_vector(CORES_PER_SIMD-1 downto 0);
      HRESP     : out std_logic_vector(CORES_PER_SIMD-1 downto 0)
      );
  end component;

  component mpsoc_wb_mpram
    generic (
      --Wishbone parameters
      DW : integer := 32;

      --Memory parameters
      DEPTH   : integer := 256;
      AW      : integer := integer(log2(real(256)));
      MEMFILE : string  := "";

      CORES_PER_TILE : integer := 8
      );
    port (
      wb_clk_i : in std_logic;
      wb_rst_i : in std_logic;

      wb_adr_i : in M_CORES_PER_TILE_AW;
      wb_dat_i : in M_CORES_PER_TILE_DW;
      wb_sel_i : in M_CORES_PER_TILE_3;
      wb_we_i  : in std_logic_vector(CORES_PER_TILE-1 downto 0);
      wb_bte_i : in M_CORES_PER_TILE_1;
      wb_cti_i : in M_CORES_PER_TILE_2;
      wb_cyc_i : in std_logic_vector(CORES_PER_TILE-1 downto 0);
      wb_stb_i : in std_logic_vector(CORES_PER_TILE-1 downto 0);

      wb_ack_o : out std_logic_vector(CORES_PER_TILE-1 downto 0);
      wb_err_o : out std_logic_vector(CORES_PER_TILE-1 downto 0);
      wb_dat_o : out M_CORES_PER_TILE_DW
      );
  end component;

begin
  --////////////////////////////////////////////////////////////////
  --
  -- Module Body
  --

  --DUT AHB3
  misd_ahb3_mpram : mpsoc_misd_ahb3_mpram
    generic map (
      MEM_SIZE          => 256,
      MEM_DEPTH         => 256,
      PLEN              => PLEN,
      XLEN              => XLEN,
      TECHNOLOGY        => TECHNOLOGY,
      REGISTERED_OUTPUT => "NO"
      )
    port map (
      HRESETn => HRESETn,
      HCLK    => HCLK,

      HSEL      => mst_misd_mpram_HSEL,
      HADDR     => mst_misd_mpram_HADDR,
      HWDATA    => mst_misd_mpram_HWDATA,
      HRDATA    => mst_misd_mpram_HRDATA,
      HWRITE    => mst_misd_mpram_HWRITE,
      HSIZE     => mst_misd_mpram_HSIZE,
      HBURST    => mst_misd_mpram_HBURST,
      HPROT     => mst_misd_mpram_HPROT,
      HTRANS    => mst_misd_mpram_HTRANS,
      HMASTLOCK => mst_misd_mpram_HMASTLOCK,
      HREADYOUT => mst_misd_mpram_HREADYOUT,
      HREADY    => mst_misd_mpram_HREADY,
      HRESP     => mst_misd_mpram_HRESP
      );

  simd_ahb3_mpram : mpsoc_simd_ahb3_mpram
    generic map (
      MEM_SIZE          => 256,
      MEM_DEPTH         => 256,
      PLEN              => PLEN,
      XLEN              => XLEN,
      TECHNOLOGY        => TECHNOLOGY,
      REGISTERED_OUTPUT => "NO"
      )
    port map (
      HRESETn => HRESETn,
      HCLK    => HCLK,

      HSEL      => mst_simd_mpram_HSEL,
      HADDR     => mst_simd_mpram_HADDR,
      HWDATA    => mst_simd_mpram_HWDATA,
      HRDATA    => mst_simd_mpram_HRDATA,
      HWRITE    => mst_simd_mpram_HWRITE,
      HSIZE     => mst_simd_mpram_HSIZE,
      HBURST    => mst_simd_mpram_HBURST,
      HPROT     => mst_simd_mpram_HPROT,
      HTRANS    => mst_simd_mpram_HTRANS,
      HMASTLOCK => mst_simd_mpram_HMASTLOCK,
      HREADYOUT => mst_simd_mpram_HREADYOUT,
      HREADY    => mst_simd_mpram_HREADY,
      HRESP     => mst_simd_mpram_HRESP
      );

  --DUT WB
  wb_mpram : mpsoc_wb_mpram
    generic map (
      DW      => DW,
      DEPTH   => DEPTH,
      AW      => AW,
      MEMFILE => MEMFILE,

      CORES_PER_TILE => CORES_PER_TILE
      )
    port map (
      wb_clk_i => HRESETn,
      wb_rst_i => HCLK,

      wb_adr_i => mst_mpram_adr_i,
      wb_dat_i => mst_mpram_dat_i,
      wb_sel_i => mst_mpram_sel_i,
      wb_we_i  => mst_mpram_we_i,
      wb_bte_i => mst_mpram_bte_i,
      wb_cti_i => mst_mpram_cti_i,
      wb_cyc_i => mst_mpram_cyc_i,
      wb_stb_i => mst_mpram_stb_i,
      wb_ack_o => mst_mpram_ack_o,
      wb_err_o => mst_mpram_err_o,
      wb_dat_o => mst_mpram_dat_o
      );
end RTL;
