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
//              Peripheral-BFM for MPSoC                                      //
//              Bus Functional Model for MPSoC                                //
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

module peripheral_mpram_testbench;

  parameter AXI_ID_WIDTH   = 10;
  parameter AXI_ADDR_WIDTH = 64;
  parameter AXI_DATA_WIDTH = 64;
  parameter AXI_STRB_WIDTH = 8;
  parameter AXI_USER_WIDTH = 10;

  logic clk_i;   // Clock
  logic rst_ni;  // Asynchronous reset active low

  logic [AXI_ID_WIDTH    -1:0] axi_aw_id;
  logic [AXI_ADDR_WIDTH  -1:0] axi_aw_addr;
  logic [                 7:0] axi_aw_len;
  logic [                 2:0] axi_aw_size;
  logic [                 1:0] axi_aw_burst;
  logic                        axi_aw_lock;
  logic [                 3:0] axi_aw_cache;
  logic [                 2:0] axi_aw_prot;
  logic [                 3:0] axi_aw_qos;
  logic [                 3:0] axi_aw_region;
  logic [AXI_USER_WIDTH  -1:0] axi_aw_user;
  logic                        axi_aw_valid;
  logic                        axi_aw_ready;

  logic [AXI_ID_WIDTH    -1:0] axi_ar_id;
  logic [AXI_ADDR_WIDTH  -1:0] axi_ar_addr;
  logic [                 7:0] axi_ar_len;
  logic [                 2:0] axi_ar_size;
  logic [                 1:0] axi_ar_burst;
  logic                        axi_ar_lock;
  logic [                 3:0] axi_ar_cache;
  logic [                 2:0] axi_ar_prot;
  logic [                 3:0] axi_ar_qos;
  logic [                 3:0] axi_ar_region;
  logic [AXI_USER_WIDTH  -1:0] axi_ar_user;
  logic                        axi_ar_valid;
  logic                        axi_ar_ready;

  logic [AXI_DATA_WIDTH  -1:0] axi_w_data;
  logic [AXI_STRB_WIDTH  -1:0] axi_w_strb;
  logic                        axi_w_last;
  logic [AXI_USER_WIDTH  -1:0] axi_w_user;
  logic                        axi_w_valid;
  logic                        axi_w_ready;

  logic [AXI_ID_WIDTH    -1:0] axi_r_id;
  logic [AXI_DATA_WIDTH  -1:0] axi_r_data;
  logic [                 1:0] axi_r_resp;
  logic                        axi_r_last;
  logic [AXI_USER_WIDTH  -1:0] axi_r_user;
  logic                        axi_r_valid;
  logic                        axi_r_ready;

  logic [AXI_ID_WIDTH    -1:0] axi_b_id;
  logic [                 1:0] axi_b_resp;
  logic [AXI_USER_WIDTH  -1:0] axi_b_user;
  logic                        axi_b_valid;
  logic                        axi_b_ready;

  peripheral_mpram_axi4 #(
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
    .axi_b_ready (axi_b_ready)
  );

endmodule  // peripheral_mpram_testbench
