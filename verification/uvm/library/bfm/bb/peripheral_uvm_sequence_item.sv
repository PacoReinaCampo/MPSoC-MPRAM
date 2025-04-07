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
//              Peripheral-NTM for MPSoC                                      //
//              Neural Turing Machine for MPSoC                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022-2025 by the author(s)
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

import peripheral_bb_pkg::*;

class peripheral_uvm_sequence_item extends uvm_sequence_item;
  // Global Signals
  bit               rst;  // Asynchronous reset active low

  rand bit [AW-1:0] addr;  // RAM address
  bit      [DW-1:0] dout;  // RAM data input
  rand bit [DW-1:0] din;   // RAM data output
  bit               cen;   // RAM chip enable (low active)
  bit      [   1:0] wen;   // RAM write enable (low active)

  // Constructor
  function new(string name = "peripheral_uvm_sequence_item");
    super.new(name);
  endfunction

  // Utility and Field declarations
  `uvm_object_utils_begin(peripheral_uvm_sequence_item)

  `uvm_field_int(rst, UVM_ALL_ON)  // Asynchronous reset active low

  `uvm_field_int(addr, UVM_ALL_ON)  // RAM address
  `uvm_field_int(dout, UVM_ALL_ON)  // RAM data input
  `uvm_field_int(din, UVM_ALL_ON)   // RAM data output
  `uvm_field_int(cen, UVM_ALL_ON)   // RAM chip enable (low active)
  `uvm_field_int(wen, UVM_ALL_ON)   // RAM write enable (low active)

  `uvm_object_utils_end

  // Constraints
  constraint addr_c {addr inside {[32'h00000000 : 32'hFFFFFFFF]};}
  constraint din_c {din inside {[32'h00000000 : 32'hFFFFFFFF]};}
endclass
