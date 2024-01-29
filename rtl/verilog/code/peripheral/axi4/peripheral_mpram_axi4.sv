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
//              Single Port SRAM                                              //
//              AMBA4 AXI-Lite Bus Interface                                  //
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

module peripheral_mpram_axi4 #(
  parameter AXI_ID_WIDTH   = 10,
  parameter AXI_ADDR_WIDTH = 64,
  parameter AXI_DATA_WIDTH = 64,
  parameter AXI_STRB_WIDTH = 8,
  parameter AXI_USER_WIDTH = 10
) (
  input logic clk_i,  // Clock
  input logic rst_ni, // Asynchronous reset active low

  input  logic [AXI_ID_WIDTH    -1:0] axi_aw_id,
  input  logic [AXI_ADDR_WIDTH  -1:0] axi_aw_addr,
  input  logic [                 7:0] axi_aw_len,
  input  logic [                 2:0] axi_aw_size,
  input  logic [                 1:0] axi_aw_burst,
  input  logic                        axi_aw_lock,
  input  logic [                 3:0] axi_aw_cache,
  input  logic [                 2:0] axi_aw_prot,
  input  logic [                 3:0] axi_aw_qos,
  input  logic [                 3:0] axi_aw_region,
  input  logic [AXI_USER_WIDTH  -1:0] axi_aw_user,
  input  logic                        axi_aw_valid,
  output logic                        axi_aw_ready,

  input  logic [AXI_ID_WIDTH    -1:0] axi_ar_id,
  input  logic [AXI_ADDR_WIDTH  -1:0] axi_ar_addr,
  input  logic [                 7:0] axi_ar_len,
  input  logic [                 2:0] axi_ar_size,
  input  logic [                 1:0] axi_ar_burst,
  input  logic                        axi_ar_lock,
  input  logic [                 3:0] axi_ar_cache,
  input  logic [                 2:0] axi_ar_prot,
  input  logic [                 3:0] axi_ar_qos,
  input  logic [                 3:0] axi_ar_region,
  input  logic [AXI_USER_WIDTH  -1:0] axi_ar_user,
  input  logic                        axi_ar_valid,
  output logic                        axi_ar_ready,

  input  logic [AXI_DATA_WIDTH  -1:0] axi_w_data,
  input  logic [AXI_STRB_WIDTH  -1:0] axi_w_strb,
  input  logic                        axi_w_last,
  input  logic [AXI_USER_WIDTH  -1:0] axi_w_user,
  input  logic                        axi_w_valid,
  output logic                        axi_w_ready,

  output logic [AXI_ID_WIDTH    -1:0] axi_r_id,
  output logic [AXI_DATA_WIDTH  -1:0] axi_r_data,
  output logic [                 1:0] axi_r_resp,
  output logic                        axi_r_last,
  output logic [AXI_USER_WIDTH  -1:0] axi_r_user,
  output logic                        axi_r_valid,
  input  logic                        axi_r_ready,

  output logic [AXI_ID_WIDTH    -1:0] axi_b_id,
  output logic [                 1:0] axi_b_resp,
  output logic [AXI_USER_WIDTH  -1:0] axi_b_user,
  output logic                        axi_b_valid,
  input  logic                        axi_b_ready
);

  logic req_int;
  logic we_int;

  logic [AXI_DATA_WIDTH/8-1:0] be_int;

  logic [AXI_ADDR_WIDTH-1:0] addr_int;

  logic [AXI_DATA_WIDTH-1:0] data_i_int;
  logic [AXI_DATA_WIDTH-1:0] data_o_int;

  peripheral_mpram_bridge_axi4 #(
    .AXI_ID_WIDTH  (AXI_ID_WIDTH),
    .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
    .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
    .AXI_STRB_WIDTH(AXI_STRB_WIDTH),
    .AXI_USER_WIDTH(AXI_USER_WIDTH)
  ) mpram_bridge_axi4 (
    .clk_i  (clk_i),
    .rst_ni (rst_ni),

    .axi_aw_id     (axi_aw_id),
    .axi_aw_addr   (axi_aw_addr),
    .axi_aw_len    (axi_aw_len),
    .axi_aw_size   (axi_aw_size),
    .axi_aw_burst  (axi_aw_burst),
    .axi_aw_lock   (axi_aw_lock),
    .axi_aw_cache  (axi_aw_cache),
    .axi_aw_prot   (axi_aw_prot),
    .axi_aw_qos    (axi_aw_qos),
    .axi_aw_region (axi_aw_region),
    .axi_aw_user   (axi_aw_user),
    .axi_aw_valid  (axi_aw_valid),
    .axi_aw_ready  (axi_aw_ready),

    .axi_ar_id     (axi_ar_id),
    .axi_ar_addr   (axi_ar_addr),
    .axi_ar_len    (axi_ar_len),
    .axi_ar_size   (axi_ar_size),
    .axi_ar_burst  (axi_ar_burst),
    .axi_ar_lock   (axi_ar_lock),
    .axi_ar_cache  (axi_ar_cache),
    .axi_ar_prot   (axi_ar_prot),
    .axi_ar_qos    (axi_ar_qos),
    .axi_ar_region (axi_ar_region),
    .axi_ar_user   (axi_ar_user),
    .axi_ar_valid  (axi_ar_valid),
    .axi_ar_ready  (axi_ar_ready),

    .axi_w_data  (axi_w_data),
    .axi_w_strb  (axi_w_strb),
    .axi_w_last  (axi_w_last),
    .axi_w_user  (axi_w_user),
    .axi_w_valid (axi_w_valid),
    .axi_w_ready (axi_w_ready),

    .axi_r_id    (axi_r_id),
    .axi_r_data  (axi_r_data),
    .axi_r_resp  (axi_r_resp),
    .axi_r_last  (axi_r_last),
    .axi_r_user  (axi_r_user),
    .axi_r_valid (axi_r_valid),
    .axi_r_ready (axi_r_ready),

    .axi_b_id    (axi_b_id),
    .axi_b_resp  (axi_b_resp),
    .axi_b_user  (axi_b_user),
    .axi_b_valid (axi_b_valid),
    .axi_b_ready (axi_b_ready),

    .req_o (req_int),
    .we_o  (we_int),
    .addr_o(addr_int),
    .be_o  (be_int),
    .data_o(data_o_int),
    .data_i(data_i_int)
  );

  peripheral_mpram_generic_axi4 #(
    .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
    .AXI_DATA_WIDTH(AXI_DATA_WIDTH)
  ) mpram_generic_axi4 (
    .rst_ni(rst_ni),
    .clk_i (clk_i),

    .req_i(req_int),
    .we_i (we_int),

    .be_i(be_int),

    .addr_i(addr_int),
    .data_i(data_o_int),

    .data_o(data_i_int)
);

endmodule  // peripheral_mpram_axi4
