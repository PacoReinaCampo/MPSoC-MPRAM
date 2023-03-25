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
//              Multi Port SRAM                                               //
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

import peripheral_ahb3_pkg::*;

module peripheral_mpram_ahb3 #(
  parameter MEM_SIZE          = 256,        //Memory in Bytes
  parameter MEM_DEPTH         = 256,        //Memory depth
  parameter PLEN              = 64,
  parameter XLEN              = 64,
  parameter TECHNOLOGY        = "GENERIC",
  parameter REGISTERED_OUTPUT = "NO",

  parameter CORES_PER_TILE = 8
) (
  input HRESETn,
  input HCLK,

  //AHB Slave Interfaces (receive data from AHB Masters)
  //AHB Masters connect to these ports
  input      [CORES_PER_TILE-1:0]           HSEL,
  input      [CORES_PER_TILE-1:0][PLEN-1:0] HADDR,
  input      [CORES_PER_TILE-1:0][XLEN-1:0] HWDATA,
  output reg [CORES_PER_TILE-1:0][XLEN-1:0] HRDATA,
  input      [CORES_PER_TILE-1:0]           HWRITE,
  input      [CORES_PER_TILE-1:0][     2:0] HSIZE,
  input      [CORES_PER_TILE-1:0][     2:0] HBURST,
  input      [CORES_PER_TILE-1:0][     3:0] HPROT,
  input      [CORES_PER_TILE-1:0][     1:0] HTRANS,
  input      [CORES_PER_TILE-1:0]           HMASTLOCK,
  output reg [CORES_PER_TILE-1:0]           HREADYOUT,
  input      [CORES_PER_TILE-1:0]           HREADY,
  output     [CORES_PER_TILE-1:0]           HRESP
);

  //////////////////////////////////////////////////////////////////////////////
  //
  // Constants
  //

  localparam BE_SIZE = (XLEN + 7) / 8;

  localparam MEM_SIZE_DEPTH = 8 * MEM_SIZE / XLEN;
  localparam REAL_MEM_DEPTH = MEM_DEPTH > MEM_SIZE_DEPTH ? MEM_DEPTH : MEM_SIZE_DEPTH;
  localparam MEM_ABITS = $clog2(REAL_MEM_DEPTH);
  localparam MEM_ABITS_LSB = $clog2(BE_SIZE);

  //////////////////////////////////////////////////////////////////////////////
  //
  // Variables
  //
  genvar t;

  logic               we        [CORES_PER_TILE];
  logic [BE_SIZE-1:0] be        [CORES_PER_TILE];
  logic [PLEN   -1:0] waddr     [CORES_PER_TILE];
  logic               contention[CORES_PER_TILE];
  logic               ready     [CORES_PER_TILE];

  logic [XLEN   -1:0] dout      [CORES_PER_TILE];

  //////////////////////////////////////////////////////////////////////////////
  //
  // Functions
  //

  function [BE_SIZE-1:0] gen_be;
    input [2:0] hsize;
    input [PLEN    -1:0] haddr;

    logic [127:0] full_be;
    logic [  6:0] haddr_masked;
    logic [  6:0] address_offset;

    //get number of active lanes for a 1024bit databus (max width) for this HSIZE
    case (hsize)
      HSIZE_B1024: full_be = 128'hffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff;
      HSIZE_B512:  full_be = 128'h0000_0000_0000_0000_ffff_ffff_ffff_ffff;
      HSIZE_B256:  full_be = 128'h0000_0000_0000_0000_0000_0000_ffff_ffff;
      HSIZE_B128:  full_be = 128'h0000_0000_0000_0000_0000_0000_0000_ffff;
      HSIZE_DWORD: full_be = 128'h0000_0000_0000_0000_0000_0000_0000_00ff;
      HSIZE_WORD:  full_be = 128'h0000_0000_0000_0000_0000_0000_0000_000f;
      HSIZE_HWORD: full_be = 128'h0000_0000_0000_0000_0000_0000_0000_0003;
      default:     full_be = 128'h0000_0000_0000_0000_0000_0000_0000_0001;
    endcase

    //What are the lesser bits in HADDR?
    case (XLEN)
      1024:    address_offset = 7'b111_1111;
      0512:    address_offset = 7'b011_1111;
      0256:    address_offset = 7'b001_1111;
      0128:    address_offset = 7'b000_1111;
      0064:    address_offset = 7'b000_0111;
      0032:    address_offset = 7'b000_0011;
      0016:    address_offset = 7'b000_0001;
      default: address_offset = 7'b000_0000;
    endcase

    //generate masked address
    haddr_masked = haddr & address_offset;

    //create byte-enable
    gen_be       = full_be[BE_SIZE-1:0] << haddr_masked;
  endfunction  //gen_be

  //////////////////////////////////////////////////////////////////////////////
  //
  // Module Body
  //

  generate
    for (t = 0; t < CORES_PER_TILE; t = t + 1) begin
      //generate internal write signal
      //This causes read/write contention[t], which is handled by memory
      always @(posedge HCLK) begin
        if (HREADY[t]) we[t] <= HSEL[t] & HWRITE[t] & (HTRANS[t] != HTRANS_BUSY) & (HTRANS[t] != HTRANS_IDLE);
        else we[t] <= 1'b0;
      end
      //decode Byte-Enables
      always @(posedge HCLK) begin
        if (HREADY[t]) be[t] <= gen_be(HSIZE[t], HADDR[t]);
      end

      //store write address
      always @(posedge HCLK) begin
        if (HREADY[t]) waddr[t] <= HADDR[t];
      end

      //Is there read/write contention[t] on the memory?
      assign contention[t] = (waddr[t][MEM_ABITS_LSB +: MEM_ABITS] == HADDR[t][MEM_ABITS_LSB +: MEM_ABITS]) & we[t] & HSEL[t] & HREADY[t] & ~HWRITE[t] & (HTRANS[t] != HTRANS_BUSY) & (HTRANS[t] != HTRANS_IDLE);

      //if all bytes were written contention[t] is/can be handled by memory
      //otherwise stall a cycle (forced by N3S)
      //We could do an exception for N3S here, but this file should be technology agnostic
      assign ready[t]      = ~(contention[t] & ~&be[t]);

      /*
       * Hookup Memory Wrapper
       * Use two-port memory, due to pipelined AHB bus;
       *   the actual write to memory is 1 cycle late, causing read/write overlap
       * This assumes there are input registers on the memory
       */

      peripheral_mpram_1r1w #(
        .ABITS     (MEM_ABITS),
        .DBITS     (XLEN),
        .TECHNOLOGY(TECHNOLOGY)
      ) ram_1r1w (
        .rst_ni(HRESETn),
        .clk_i (HCLK),

        .waddr_i(waddr[t][MEM_ABITS_LSB+:MEM_ABITS]),
        .we_i   (we[t]),
        .be_i   (be[t]),
        .din_i  (HWDATA[t]),

        .re_i   (1'b0),
        .raddr_i(HADDR[t][MEM_ABITS_LSB+:MEM_ABITS]),
        .dout_o (dout[t])
      );

      //AHB bus response
      assign HRESP[t] = HRESP_OKAY;  //always OK

      if (REGISTERED_OUTPUT == "NO") begin
        always @(posedge HCLK, negedge HRESETn) begin
          if (!HRESETn) HREADYOUT[t] <= 1'b1;
          else HREADYOUT[t] <= ready[t];
        end
        always @* HRDATA[t] = dout[t];
      end else begin
        always @(posedge HCLK, negedge HRESETn) begin
          if (!HRESETn) HREADYOUT[t] <= 1'b1;
          else if (HTRANS[t] == HTRANS_NONSEQ && !HWRITE[t]) HREADYOUT[t] <= 1'b0;
          else HREADYOUT[t] <= 1'b1;
        end
        always @(posedge HCLK) begin
          if (HREADY[t]) HRDATA[t] <= dout[t];
        end
      end
    end
  endgenerate
endmodule
