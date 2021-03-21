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
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

module peripheral_mpram_testbench;

  //////////////////////////////////////////////////////////////////
  //
  // Constants
  //

  //Memory parameters
  parameter DEPTH   = 256;
  parameter MEMFILE = "";

  //Wishbone parameters
  parameter DW = 32;
  parameter AW = $clog2(DEPTH);

  localparam CORES_PER_TILE = 8;

  //////////////////////////////////////////////////////////////////
  //
  // Variables
  //

  //Common signals
  wire                                            clk;
  wire                                            rst;

  //WB signals
  wire  [CORES_PER_TILE-1:0][AW             -1:0] mst_mpram_adr_i;
  wire  [CORES_PER_TILE-1:0][DW             -1:0] mst_mpram_dat_i;
  wire  [CORES_PER_TILE-1:0][                3:0] mst_mpram_sel_i;
  wire  [CORES_PER_TILE-1:0]                      mst_mpram_we_i;
  wire  [CORES_PER_TILE-1:0][                1:0] mst_mpram_bte_i;
  wire  [CORES_PER_TILE-1:0][                2:0] mst_mpram_cti_i;
  wire  [CORES_PER_TILE-1:0]                      mst_mpram_cyc_i;
  wire  [CORES_PER_TILE-1:0]                      mst_mpram_stb_i;
  reg   [CORES_PER_TILE-1:0]                      mst_mpram_ack_o;
  wire  [CORES_PER_TILE-1:0]                      mst_mpram_err_o;
  wire  [CORES_PER_TILE-1:0][DW             -1:0] mst_mpram_dat_o;

  //////////////////////////////////////////////////////////////////
  //
  // Module Body
  //

  //DUT WB
  peripheral_mpram_wb #(
    .DEPTH   ( DEPTH   ),
    .MEMFILE ( MEMFILE ),

    .DW      ( DW ),
    .AW      ( AW ),

    .CORES_PER_TILE ( CORES_PER_TILE )
  )
  wb_mpram (
    //Wishbone Master interface
    .wb_clk_i ( HRESETn ),
    .wb_rst_i ( HCLK    ),

    .wb_adr_i ( mst_mpram_adr_i ),
    .wb_dat_i ( mst_mpram_dat_i ),
    .wb_sel_i ( mst_mpram_sel_i ),
    .wb_we_i  ( mst_mpram_we_i  ),
    .wb_bte_i ( mst_mpram_bte_i ),
    .wb_cti_i ( mst_mpram_cti_i ),
    .wb_cyc_i ( mst_mpram_cyc_i ),
    .wb_stb_i ( mst_mpram_stb_i ),
    .wb_ack_o ( mst_mpram_ack_o ),
    .wb_err_o ( mst_mpram_err_o ),
    .wb_dat_o ( mst_mpram_dat_o )
  );
endmodule
