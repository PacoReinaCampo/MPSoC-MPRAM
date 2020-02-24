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

use work.mpsoc_pkg.all;

entity mpsoc_msi_testbench is
end mpsoc_msi_testbench;

architecture RTL of mpsoc_msi_testbench is
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

  component mpsoc_misd_wb_mpram
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

  component mpsoc_simd_wb_mpram
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

  --////////////////////////////////////////////////////////////////
  --
  -- Variables
  --

  --Common signals
  signal HRESETn : std_logic;
  signal HCLK    : std_logic;

  signal mst_misd_mram_HSEL      : std_logic_vector(CORES_PER_MISD-1 downto 0);
  signal mst_misd_mram_HADDR     : M_CORES_PER_MISD_PLEN;
  signal mst_misd_mram_HWDATA    : M_CORES_PER_MISD_XLEN;
  signal mst_misd_mram_HRDATA    : M_CORES_PER_MISD_XLEN;
  signal mst_misd_mram_HWRITE    : std_logic_vector(CORES_PER_MISD-1 downto 0);
  signal mst_misd_mram_HSIZE     : M_CORES_PER_MISD_2;
  signal mst_misd_mram_HBURST    : M_CORES_PER_MISD_2;
  signal mst_misd_mram_HPROT     : M_CORES_PER_MISD_3;
  signal mst_misd_mram_HTRANS    : M_CORES_PER_MISD_1;
  signal mst_misd_mram_HMASTLOCK : std_logic_vector(CORES_PER_MISD-1 downto 0);
  signal mst_misd_mram_HREADY    : std_logic_vector(CORES_PER_MISD-1 downto 0);
  signal mst_misd_mram_HREADYOUT : std_logic_vector(CORES_PER_MISD-1 downto 0);
  signal mst_misd_mram_HRESP     : std_logic_vector(CORES_PER_MISD-1 downto 0);

  signal mst_simd_mram_HSEL      : std_logic_vector(CORES_PER_SIMD-1 downto 0);
  signal mst_simd_mram_HADDR     : M_CORES_PER_SIMD_PLEN;
  signal mst_simd_mram_HWDATA    : M_CORES_PER_SIMD_XLEN;
  signal mst_simd_mram_HRDATA    : M_CORES_PER_SIMD_XLEN;
  signal mst_simd_mram_HWRITE    : std_logic_vector(CORES_PER_SIMD-1 downto 0);
  signal mst_simd_mram_HSIZE     : M_CORES_PER_SIMD_2;
  signal mst_simd_mram_HBURST    : M_CORES_PER_SIMD_2;
  signal mst_simd_mram_HPROT     : M_CORES_PER_SIMD_3;
  signal mst_simd_mram_HTRANS    : M_CORES_PER_SIMD_1;
  signal mst_simd_mram_HMASTLOCK : std_logic_vector(CORES_PER_SIMD-1 downto 0);
  signal mst_simd_mram_HREADY    : std_logic_vector(CORES_PER_SIMD-1 downto 0);
  signal mst_simd_mram_HREADYOUT : std_logic_vector(CORES_PER_SIMD-1 downto 0);
  signal mst_simd_mram_HRESP     : std_logic_vector(CORES_PER_SIMD-1 downto 0);

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
      --AHB Slave Interface
      HRESETn => HRESETn,
      HCLK    => HCLK,

      HSEL      => mst_misd_mram_HSEL,
      HADDR     => mst_misd_mram_HADDR,
      HWDATA    => mst_misd_mram_HWDATA,
      HRDATA    => mst_misd_mram_HRDATA,
      HWRITE    => mst_misd_mram_HWRITE,
      HSIZE     => mst_misd_mram_HSIZE,
      HBURST    => mst_misd_mram_HBURST,
      HPROT     => mst_misd_mram_HPROT,
      HTRANS    => mst_misd_mram_HTRANS,
      HMASTLOCK => mst_misd_mram_HMASTLOCK,
      HREADYOUT => mst_misd_mram_HREADYOUT,
      HREADY    => mst_misd_mram_HREADY,
      HRESP     => mst_misd_mram_HRESP
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
      --AHB Slave Interface
      HRESETn => HRESETn,
      HCLK    => HCLK,

      HSEL      => mst_simd_mram_HSEL,
      HADDR     => mst_simd_mram_HADDR,
      HWDATA    => mst_simd_mram_HWDATA,
      HRDATA    => mst_simd_mram_HRDATA,
      HWRITE    => mst_simd_mram_HWRITE,
      HSIZE     => mst_simd_mram_HSIZE,
      HBURST    => mst_simd_mram_HBURST,
      HPROT     => mst_simd_mram_HPROT,
      HTRANS    => mst_simd_mram_HTRANS,
      HMASTLOCK => mst_simd_mram_HMASTLOCK,
      HREADYOUT => mst_simd_mram_HREADYOUT,
      HREADY    => mst_simd_mram_HREADY,
      HRESP     => mst_simd_mram_HRESP
      );

  --DUT WB
  misd_wb_mpram : mpsoc_misd_wb_mpram
    generic map (
      MEM_SIZE          => 256,
      MEM_DEPTH         => 256,
      PLEN              => PLEN,
      XLEN              => XLEN,
      TECHNOLOGY        => TECHNOLOGY,
      REGISTERED_OUTPUT => "NO"
      )
    port map (
      --AHB Slave Interface
      HRESETn => HRESETn,
      HCLK    => HCLK,

      HSEL      => mst_misd_mram_HSEL,
      HADDR     => mst_misd_mram_HADDR,
      HWDATA    => mst_misd_mram_HWDATA,
      HRDATA    => open,
      HWRITE    => mst_misd_mram_HWRITE,
      HSIZE     => mst_misd_mram_HSIZE,
      HBURST    => mst_misd_mram_HBURST,
      HPROT     => mst_misd_mram_HPROT,
      HTRANS    => mst_misd_mram_HTRANS,
      HMASTLOCK => mst_misd_mram_HMASTLOCK,
      HREADYOUT => open,
      HREADY    => mst_misd_mram_HREADY,
      HRESP     => open
      );

  simd_wb_mpram : mpsoc_simd_wb_mpram
    generic map (
      MEM_SIZE          => 256,
      MEM_DEPTH         => 256,
      PLEN              => PLEN,
      XLEN              => XLEN,
      TECHNOLOGY        => TECHNOLOGY,
      REGISTERED_OUTPUT => "NO"
      )
    port map (
      --AHB Slave Interface
      HRESETn => HRESETn,
      HCLK    => HCLK,

      HSEL      => mst_simd_mram_HSEL,
      HADDR     => mst_simd_mram_HADDR,
      HWDATA    => mst_simd_mram_HWDATA,
      HRDATA    => open,
      HWRITE    => mst_simd_mram_HWRITE,
      HSIZE     => mst_simd_mram_HSIZE,
      HBURST    => mst_simd_mram_HBURST,
      HPROT     => mst_simd_mram_HPROT,
      HTRANS    => mst_simd_mram_HTRANS,
      HMASTLOCK => mst_simd_mram_HMASTLOCK,
      HREADYOUT => open,
      HREADY    => mst_simd_mram_HREADY,
      HRESP     => open
      );
end RTL;
