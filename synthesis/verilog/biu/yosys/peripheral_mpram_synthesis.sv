////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              MPSoC-RISCV CPU                                               //
//              Master Slave Interface Tesbench                               //
//              AMBA3 AHB-Lite Bus Interface                                  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018-2019 by the author(s)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
////////////////////////////////////////////////////////////////////////////////
// Author(s):
//   Paco Reina Campo <pacoreinacampo@queenfield.tech>

module peripheral_mpram_synthesis #(
  parameter MEM_SIZE          = 256,        // Memory in Bytes
  parameter MEM_DEPTH         = 256,        // Memory depth
  parameter PLEN              = 8,
  parameter XLEN              = 32,
  parameter TECHNOLOGY        = "GENERIC",
  parameter REGISTERED_OUTPUT = "NO",

  parameter CORES_PER_TILE = 1
) (
  input HRESETn,
  input HCLK,

  input                 HSEL,
  input      [PLEN-1:0] HADDR,
  input      [XLEN-1:0] HWDATA,
  output reg [XLEN-1:0] HRDATA,
  input                 HWRITE,
  input      [     2:0] HSIZE,
  input      [     2:0] HBURST,
  input      [     3:0] HPROT,
  input      [     1:0] HTRANS,
  input                 HMASTLOCK,
  output reg            HREADYOUT,
  input                 HREADY,
  output                HRESP
);

  //////////////////////////////////////////////////////////////////////////////
  // Variables
  //////////////////////////////////////////////////////////////////////////////

  wire [CORES_PER_TILE-1:0]           slv_HSEL;
  wire [CORES_PER_TILE-1:0][PLEN-1:0] slv_HADDR;
  wire [CORES_PER_TILE-1:0][XLEN-1:0] slv_HWDATA;
  wire [CORES_PER_TILE-1:0][XLEN-1:0] slv_HRDATA;
  wire [CORES_PER_TILE-1:0]           slv_HWRITE;
  wire [CORES_PER_TILE-1:0][     2:0] slv_HSIZE;
  wire [CORES_PER_TILE-1:0][     2:0] slv_HBURST;
  wire [CORES_PER_TILE-1:0][     3:0] slv_HPROT;
  wire [CORES_PER_TILE-1:0][     1:0] slv_HTRANS;
  wire [CORES_PER_TILE-1:0]           slv_HMASTLOCK;
  wire [CORES_PER_TILE-1:0]           slv_HREADYOUT;
  wire [CORES_PER_TILE-1:0]           slv_HREADY;
  wire [CORES_PER_TILE-1:0]           slv_HRESP;

  //////////////////////////////////////////////////////////////////////////////
  // Body
  //////////////////////////////////////////////////////////////////////////////

  // DUT AHB4
  assign slv_HSEL      [0] = HSEL;
  assign slv_HADDR     [0] = HADDR;
  assign slv_HWDATA    [0] = HWDATA;
  assign slv_HWRITE    [0] = HWRITE;
  assign slv_HSIZE     [0] = HSIZE;
  assign slv_HBURST    [0] = HBURST;
  assign slv_HPROT     [0] = HPROT;
  assign slv_HTRANS    [0] = HTRANS;
  assign slv_HMASTLOCK [0] = HMASTLOCK;
  assign slv_HREADY    [0] = HREADY;

  assign HRDATA    = slv_HRDATA    [0];
  assign HREADYOUT = slv_HREADYOUT [0];
  assign HRESP     = slv_HRESP     [0];

  peripheral_mpram_ahb4 #(
    .MEM_SIZE         (MEM_SIZE),
    .MEM_DEPTH        (MEM_DEPTH),
    .PLEN             (PLEN),
    .XLEN             (XLEN),
    .TECHNOLOGY       (TECHNOLOGY),
    .REGISTERED_OUTPUT(REGISTERED_OUTPUT)
  ) mpram_ahb4 (
    .HRESETn(HRESETn),
    .HCLK   (HCLK),

    .HSEL     (slv_HSEL),
    .HADDR    (slv_HADDR),
    .HWDATA   (slv_HWDATA),
    .HRDATA   (slv_HRDATA),
    .HWRITE   (slv_HWRITE),
    .HSIZE    (slv_HSIZE),
    .HBURST   (slv_HBURST),
    .HPROT    (slv_HPROT),
    .HTRANS   (slv_HTRANS),
    .HMASTLOCK(slv_HMASTLOCK),
    .HREADYOUT(slv_HREADYOUT),
    .HREADY   (slv_HREADY),
    .HRESP    (slv_HRESP)
  );
endmodule
