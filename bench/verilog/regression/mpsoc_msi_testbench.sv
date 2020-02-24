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

/* Copyright (c) 2018-2019 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 * Author(s):
 *   Francisco Javier Reina Campo <frareicam@gmail.com>
 */

module mpsoc_msi_testbench;

  //////////////////////////////////////////////////////////////////
  //
  // Constants
  //
  localparam XLEN = 64;
  localparam PLEN = 64;

  localparam MASTERS = 5;
  localparam SLAVES  = 5;

  localparam SYNC_DEPTH = 3;
  localparam TECHNOLOGY = "GENERIC";

  //////////////////////////////////////////////////////////////////
  //
  // Variables
  //

  //Common signals
  wire                                     HRESETn;
  wire                                     HCLK;

  wire  [MASTERS-1:0]                      mst_mram_HSEL;
  wire  [MASTERS-1:0][PLEN           -1:0] mst_mram_HADDR;
  wire  [MASTERS-1:0][XLEN           -1:0] mst_mram_HWDATA;
  wire  [MASTERS-1:0][XLEN           -1:0] mst_mram_HRDATA;
  wire  [MASTERS-1:0]                      mst_mram_HWRITE;
  wire  [MASTERS-1:0][                2:0] mst_mram_HSIZE;
  wire  [MASTERS-1:0][                2:0] mst_mram_HBURST;
  wire  [MASTERS-1:0][                3:0] mst_mram_HPROT;
  wire  [MASTERS-1:0][                1:0] mst_mram_HTRANS;
  wire  [MASTERS-1:0]                      mst_mram_HMASTLOCK;
  wire  [MASTERS-1:0]                      mst_mram_HREADY;
  wire  [MASTERS-1:0]                      mst_mram_HREADYOUT;
  wire  [MASTERS-1:0]                      mst_mram_HRESP;

  //////////////////////////////////////////////////////////////////
  //
  // Module Body
  //

  //DUT

  //Instantiate RISC-V RAM
  mpsoc_ahb3_mpram #(
    .MEM_SIZE          ( 0 ),
    .MEM_DEPTH         ( 256 ),
    .HADDR_SIZE        ( PLEN ),
    .HDATA_SIZE        ( XLEN ),
    .CORES_PER_TILE    ( MASTERS ),
    .TECHNOLOGY        ( TECHNOLOGY ),
    .REGISTERED_OUTPUT ( "NO" )
  )
  ahb3_mpram (
    //AHB Slave Interface
    .HRESETn   ( HRESETn ),
    .HCLK      ( HCLK    ),

    .HSEL      ( mst_mram_HSEL      ),
    .HADDR     ( mst_mram_HADDR     ),
    .HWDATA    ( mst_mram_HWDATA    ),
    .HRDATA    ( mst_mram_HRDATA    ),
    .HWRITE    ( mst_mram_HWRITE    ),
    .HSIZE     ( mst_mram_HSIZE     ),
    .HBURST    ( mst_mram_HBURST    ),
    .HPROT     ( mst_mram_HPROT     ),
    .HTRANS    ( mst_mram_HTRANS    ),
    .HMASTLOCK ( mst_mram_HMASTLOCK ),
    .HREADYOUT ( mst_mram_HREADYOUT ),
    .HREADY    ( mst_mram_HREADY    ),
    .HRESP     ( mst_mram_HRESP     )
  );

  mpsoc_wb_mpram #(
    .MEM_SIZE          ( 0 ),
    .MEM_DEPTH         ( 256 ),
    .HADDR_SIZE        ( PLEN ),
    .HDATA_SIZE        ( XLEN ),
    .CORES_PER_TILE    ( MASTERS ),
    .TECHNOLOGY        ( TECHNOLOGY ),
    .REGISTERED_OUTPUT ( "NO" )
  )
  wb_mpram (
    //AHB Slave Interface
    .HRESETn   ( HRESETn ),
    .HCLK      ( HCLK    ),

    .HSEL      (       ),
    .HADDR     (      ),
    .HWDATA    (     ),
    .HRDATA    (     ),
    .HWRITE    (     ),
    .HSIZE     (      ),
    .HBURST    (     ),
    .HPROT     (      ),
    .HTRANS    (     ),
    .HMASTLOCK (  ),
    .HREADYOUT (  ),
    .HREADY    (     ),
    .HRESP     (      )
  );
endmodule
