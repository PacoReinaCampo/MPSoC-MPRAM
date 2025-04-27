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

  localparam PLEN = 64;
  localparam XLEN = 64;

  logic clk;
  logic rst;

  // TILELINK Bus (Core ports)
  logic            biu_stb_i;      // strobe
  logic            biu_stb_ack_o;  // strobe acknowledge; can send new strobe
  logic            biu_d_ack_o;    // data acknowledge (send new biu_d_i); for pipelined buses
  logic [PLEN-1:0] biu_adri_i;
  logic [PLEN-1:0] biu_adro_o;
  logic [     2:0] biu_size_i;     // transfer size
  logic [     2:0] biu_type_i;     // burst type
  logic [     2:0] biu_prot_i;     // protection
  logic            biu_lock_i;
  logic            biu_we_i;
  logic [XLEN-1:0] biu_d_i;
  logic [XLEN-1:0] biu_q_o;
  logic            biu_ack_o;      // transfer acknowledge
  logic            biu_err_o;      // transfer error

  peripheral_mpram_tl #(
    .XLEN(XLEN),
    .PLEN(PLEN)
  ) mpram_tl (
    .clk(clk),
    .rst(rst),

    // TILELINK Bus (Core ports)
    .biu_stb_i    (biu_stb_i),      // strobe
    .biu_stb_ack_o(biu_stb_ack_o),  // strobe acknowledge; can send new strobe
    .biu_d_ack_o  (biu_d_ack_o),    // data acknowledge (send new biu_d_i); for pipelined buses
    .biu_adri_i   (biu_adri_i),
    .biu_adro_o   (biu_adro_o),
    .biu_size_i   (biu_size_i),     // transfer size
    .biu_type_i   (biu_type_i),     // burst type
    .biu_prot_i   (biu_prot_i),     // protection
    .biu_lock_i   (biu_lock_i),
    .biu_we_i     (biu_we_i),
    .biu_d_i      (biu_d_i),
    .biu_q_o      (biu_q_o),
    .biu_ack_o    (biu_ack_o),      // transfer acknowledge
    .biu_err_o    (biu_err_o)       // transfer error
  );

endmodule  // peripheral_mpram_testbench
