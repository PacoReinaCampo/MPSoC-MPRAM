// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Mon Dec 21 05:09:40 2020
// Host        : eq1 running 64-bit Ubuntu 20.04.1 LTS
// Command     : write_verilog -force system_wb.v
// Design      : mpsoc_wb_spram
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mpsoc_wb_ram_generic
   (wb_dat_o_OBUF,
    D,
    CLK,
    Q,
    wb_dat_i_IBUF,
    wb_adr_i_IBUF,
    wb_cti_i_IBUF,
    wb_bte_i_IBUF,
    is_last_r,
    wb_stb_i_IBUF,
    wb_cyc_i_IBUF,
    valid_r,
    wb_sel_i_IBUF,
    wb_ack_o_OBUF,
    wb_we_i_IBUF);
  output [31:0]wb_dat_o_OBUF;
  output [5:0]D;
  input CLK;
  input [5:0]Q;
  input [31:0]wb_dat_i_IBUF;
  input [5:0]wb_adr_i_IBUF;
  input [2:0]wb_cti_i_IBUF;
  input [1:0]wb_bte_i_IBUF;
  input is_last_r;
  input wb_stb_i_IBUF;
  input wb_cyc_i_IBUF;
  input valid_r;
  input [3:0]wb_sel_i_IBUF;
  input wb_ack_o_OBUF;
  input wb_we_i_IBUF;

  wire \<const0> ;
  wire \<const1> ;
  wire CLK;
  wire [5:0]D;
  wire [5:0]Q;
  wire is_last_r;
  wire mem_reg_i_10_n_0;
  wire mem_reg_i_11_n_0;
  wire mem_reg_i_12_n_0;
  wire mem_reg_i_13_n_0;
  wire mem_reg_i_14_n_0;
  wire mem_reg_i_15_n_0;
  wire mem_reg_i_7_n_0;
  wire mem_reg_i_8_n_0;
  wire mem_reg_i_9_n_0;
  wire valid_r;
  wire wb_ack_o_OBUF;
  wire [5:0]wb_adr_i_IBUF;
  wire [1:0]wb_bte_i_IBUF;
  wire [2:0]wb_cti_i_IBUF;
  wire wb_cyc_i_IBUF;
  wire [31:0]wb_dat_i_IBUF;
  wire [31:0]wb_dat_o_OBUF;
  wire [3:0]wb_sel_i_IBUF;
  wire wb_stb_i_IBUF;
  wire wb_we_i_IBUF;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d8_p0_d8" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d8_p0_d8" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "ram0/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "448" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "31" *) 
  RAMB18E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(36),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(36)) 
    mem_reg
       (.ADDRARDADDR({\<const1> ,\<const1> ,\<const1> ,D,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({\<const1> ,\<const1> ,\<const1> ,Q,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CLKARDCLK(CLK),
        .CLKBWRCLK(CLK),
        .DIADI(wb_dat_i_IBUF[15:0]),
        .DIBDI(wb_dat_i_IBUF[31:16]),
        .DIPADIP({\<const1> ,\<const1> }),
        .DIPBDIP({\<const1> ,\<const1> }),
        .DOADO(wb_dat_o_OBUF[15:0]),
        .DOBDO(wb_dat_o_OBUF[31:16]),
        .ENARDEN(\<const1> ),
        .ENBWREN(\<const1> ),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({\<const0> ,\<const0> }),
        .WEBWE({mem_reg_i_7_n_0,mem_reg_i_8_n_0,mem_reg_i_9_n_0,mem_reg_i_10_n_0}));
  LUT6 #(
    .INIT(64'hB88BB8B8B8B8B8B8)) 
    mem_reg_i_1
       (.I0(wb_adr_i_IBUF[5]),
        .I1(mem_reg_i_11_n_0),
        .I2(Q[5]),
        .I3(mem_reg_i_12_n_0),
        .I4(Q[4]),
        .I5(mem_reg_i_13_n_0),
        .O(D[5]));
  LUT5 #(
    .INIT(32'h80000000)) 
    mem_reg_i_10
       (.I0(wb_sel_i_IBUF[0]),
        .I1(wb_ack_o_OBUF),
        .I2(wb_we_i_IBUF),
        .I3(wb_stb_i_IBUF),
        .I4(wb_cyc_i_IBUF),
        .O(mem_reg_i_10_n_0));
  LUT4 #(
    .INIT(16'hAAEA)) 
    mem_reg_i_11
       (.I0(is_last_r),
        .I1(wb_stb_i_IBUF),
        .I2(wb_cyc_i_IBUF),
        .I3(valid_r),
        .O(mem_reg_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    mem_reg_i_12
       (.I0(wb_bte_i_IBUF[1]),
        .I1(Q[3]),
        .I2(wb_bte_i_IBUF[0]),
        .O(mem_reg_i_12_n_0));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    mem_reg_i_13
       (.I0(wb_cti_i_IBUF[0]),
        .I1(wb_cti_i_IBUF[2]),
        .I2(wb_cti_i_IBUF[1]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(Q[1]),
        .O(mem_reg_i_13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h77F7)) 
    mem_reg_i_14
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(wb_bte_i_IBUF[0]),
        .I3(wb_bte_i_IBUF[1]),
        .O(mem_reg_i_14_n_0));
  LUT3 #(
    .INIT(8'h02)) 
    mem_reg_i_15
       (.I0(wb_cti_i_IBUF[1]),
        .I1(wb_cti_i_IBUF[2]),
        .I2(wb_cti_i_IBUF[0]),
        .O(mem_reg_i_15_n_0));
  LUT5 #(
    .INIT(32'hB88BB8B8)) 
    mem_reg_i_2
       (.I0(wb_adr_i_IBUF[4]),
        .I1(mem_reg_i_11_n_0),
        .I2(Q[4]),
        .I3(mem_reg_i_12_n_0),
        .I4(mem_reg_i_13_n_0),
        .O(D[4]));
  LUT6 #(
    .INIT(64'h8BB8B88BB8B8B8B8)) 
    mem_reg_i_3
       (.I0(wb_adr_i_IBUF[3]),
        .I1(mem_reg_i_11_n_0),
        .I2(Q[3]),
        .I3(wb_bte_i_IBUF[1]),
        .I4(wb_bte_i_IBUF[0]),
        .I5(mem_reg_i_13_n_0),
        .O(D[3]));
  LUT5 #(
    .INIT(32'hB88BB8B8)) 
    mem_reg_i_4
       (.I0(wb_adr_i_IBUF[2]),
        .I1(mem_reg_i_11_n_0),
        .I2(Q[2]),
        .I3(mem_reg_i_14_n_0),
        .I4(mem_reg_i_15_n_0),
        .O(D[2]));
  LUT5 #(
    .INIT(32'h8BBBB888)) 
    mem_reg_i_5
       (.I0(wb_adr_i_IBUF[1]),
        .I1(mem_reg_i_11_n_0),
        .I2(Q[0]),
        .I3(mem_reg_i_15_n_0),
        .I4(Q[1]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hB8B8B88BB8B8B8B8)) 
    mem_reg_i_6
       (.I0(wb_adr_i_IBUF[0]),
        .I1(mem_reg_i_11_n_0),
        .I2(Q[0]),
        .I3(wb_cti_i_IBUF[0]),
        .I4(wb_cti_i_IBUF[2]),
        .I5(wb_cti_i_IBUF[1]),
        .O(D[0]));
  LUT5 #(
    .INIT(32'h80000000)) 
    mem_reg_i_7
       (.I0(wb_sel_i_IBUF[3]),
        .I1(wb_ack_o_OBUF),
        .I2(wb_we_i_IBUF),
        .I3(wb_stb_i_IBUF),
        .I4(wb_cyc_i_IBUF),
        .O(mem_reg_i_7_n_0));
  LUT5 #(
    .INIT(32'h80000000)) 
    mem_reg_i_8
       (.I0(wb_sel_i_IBUF[2]),
        .I1(wb_ack_o_OBUF),
        .I2(wb_we_i_IBUF),
        .I3(wb_stb_i_IBUF),
        .I4(wb_cyc_i_IBUF),
        .O(mem_reg_i_8_n_0));
  LUT5 #(
    .INIT(32'h80000000)) 
    mem_reg_i_9
       (.I0(wb_sel_i_IBUF[1]),
        .I1(wb_ack_o_OBUF),
        .I2(wb_we_i_IBUF),
        .I3(wb_stb_i_IBUF),
        .I4(wb_cyc_i_IBUF),
        .O(mem_reg_i_9_n_0));
endmodule

(* AW = "8" *) (* BTE_LINEAR = "2'b00" *) (* BTE_WRAP_16 = "2'b11" *) 
(* BTE_WRAP_4 = "2'b01" *) (* BTE_WRAP_8 = "2'b10" *) (* BURST_CYCLE = "1'b1" *) 
(* CLASSIC_CYCLE = "1'b0" *) (* CTI_CLASSIC = "3'b000" *) (* CTI_CONST_BURST = "3'b001" *) 
(* CTI_END_OF_BURST = "3'b111" *) (* CTI_INC_BURST = "3'b010" *) (* DEPTH = "256" *) 
(* DW = "32" *) (* ECO_CHECKSUM = "f663d88e" *) (* MEMFILE = "" *) 
(* POWER_OPT_BRAM_CDC = "0" *) (* POWER_OPT_BRAM_SR_ADDR = "0" *) (* POWER_OPT_LOOPED_NET_PERCENTAGE = "0" *) 
(* READ = "1'b0" *) (* WRITE = "1'b1" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module mpsoc_wb_spram
   (wb_clk_i,
    wb_rst_i,
    wb_adr_i,
    wb_dat_i,
    wb_sel_i,
    wb_we_i,
    wb_bte_i,
    wb_cti_i,
    wb_cyc_i,
    wb_stb_i,
    wb_ack_o,
    wb_err_o,
    wb_dat_o);
  input wb_clk_i;
  input wb_rst_i;
  input [7:0]wb_adr_i;
  input [31:0]wb_dat_i;
  input [3:0]wb_sel_i;
  input wb_we_i;
  input [1:0]wb_bte_i;
  input [2:0]wb_cti_i;
  input wb_cyc_i;
  input wb_stb_i;
  output wb_ack_o;
  output wb_err_o;
  output [31:0]wb_dat_o;

  wire \<const0> ;
  wire \<const1> ;
  wire [7:2]adr;
  wire [7:2]adr_r;
  wire is_last_r;
  wire p_2_in;
  wire valid_r;
  wire wb_ack_o;
  wire wb_ack_o_OBUF;
  wire wb_ack_o_i_1_n_0;
  wire [7:0]wb_adr_i;
  wire [7:2]wb_adr_i_IBUF;
  wire [1:0]wb_bte_i;
  wire [1:0]wb_bte_i_IBUF;
  wire wb_clk_i;
  wire wb_clk_i_IBUF;
  wire wb_clk_i_IBUF_BUFG;
  wire [2:0]wb_cti_i;
  wire [2:0]wb_cti_i_IBUF;
  wire wb_cyc_i;
  wire wb_cyc_i_IBUF;
  wire [31:0]wb_dat_i;
  wire [31:0]wb_dat_i_IBUF;
  wire [31:0]wb_dat_o;
  wire [31:0]wb_dat_o_OBUF;
  wire wb_err_o;
  wire wb_is_last_return;
  wire wb_rst_i;
  wire wb_rst_i_IBUF;
  wire [3:0]wb_sel_i;
  wire [3:0]wb_sel_i_IBUF;
  wire wb_stb_i;
  wire wb_stb_i_IBUF;
  wire wb_we_i;
  wire wb_we_i_IBUF;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  FDRE \adr_r_reg[2] 
       (.C(wb_clk_i_IBUF_BUFG),
        .CE(\<const1> ),
        .D(adr[2]),
        .Q(adr_r[2]),
        .R(wb_rst_i_IBUF));
  FDRE \adr_r_reg[3] 
       (.C(wb_clk_i_IBUF_BUFG),
        .CE(\<const1> ),
        .D(adr[3]),
        .Q(adr_r[3]),
        .R(wb_rst_i_IBUF));
  FDRE \adr_r_reg[4] 
       (.C(wb_clk_i_IBUF_BUFG),
        .CE(\<const1> ),
        .D(adr[4]),
        .Q(adr_r[4]),
        .R(wb_rst_i_IBUF));
  FDRE \adr_r_reg[5] 
       (.C(wb_clk_i_IBUF_BUFG),
        .CE(\<const1> ),
        .D(adr[5]),
        .Q(adr_r[5]),
        .R(wb_rst_i_IBUF));
  FDRE \adr_r_reg[6] 
       (.C(wb_clk_i_IBUF_BUFG),
        .CE(\<const1> ),
        .D(adr[6]),
        .Q(adr_r[6]),
        .R(wb_rst_i_IBUF));
  FDRE \adr_r_reg[7] 
       (.C(wb_clk_i_IBUF_BUFG),
        .CE(\<const1> ),
        .D(adr[7]),
        .Q(adr_r[7]),
        .R(wb_rst_i_IBUF));
  LUT3 #(
    .INIT(8'hAB)) 
    is_last_r_i_1
       (.I0(wb_cti_i_IBUF[2]),
        .I1(wb_cti_i_IBUF[1]),
        .I2(wb_cti_i_IBUF[0]),
        .O(wb_is_last_return));
  FDRE is_last_r_reg
       (.C(wb_clk_i_IBUF_BUFG),
        .CE(\<const1> ),
        .D(wb_is_last_return),
        .Q(is_last_r),
        .R(\<const0> ));
  mpsoc_wb_ram_generic ram0
       (.CLK(wb_clk_i_IBUF_BUFG),
        .D(adr),
        .Q(adr_r),
        .is_last_r(is_last_r),
        .valid_r(valid_r),
        .wb_ack_o_OBUF(wb_ack_o_OBUF),
        .wb_adr_i_IBUF(wb_adr_i_IBUF),
        .wb_bte_i_IBUF(wb_bte_i_IBUF),
        .wb_cti_i_IBUF(wb_cti_i_IBUF),
        .wb_cyc_i_IBUF(wb_cyc_i_IBUF),
        .wb_dat_i_IBUF(wb_dat_i_IBUF),
        .wb_dat_o_OBUF(wb_dat_o_OBUF),
        .wb_sel_i_IBUF(wb_sel_i_IBUF),
        .wb_stb_i_IBUF(wb_stb_i_IBUF),
        .wb_we_i_IBUF(wb_we_i_IBUF));
  LUT2 #(
    .INIT(4'h8)) 
    valid_r_i_1
       (.I0(wb_cyc_i_IBUF),
        .I1(wb_stb_i_IBUF),
        .O(p_2_in));
  FDRE valid_r_reg
       (.C(wb_clk_i_IBUF_BUFG),
        .CE(\<const1> ),
        .D(p_2_in),
        .Q(valid_r),
        .R(wb_rst_i_IBUF));
  OBUF wb_ack_o_OBUF_inst
       (.I(wb_ack_o_OBUF),
        .O(wb_ack_o));
  LUT6 #(
    .INIT(64'h0888888088888888)) 
    wb_ack_o_i_1
       (.I0(wb_cyc_i_IBUF),
        .I1(wb_stb_i_IBUF),
        .I2(wb_cti_i_IBUF[1]),
        .I3(wb_cti_i_IBUF[0]),
        .I4(wb_cti_i_IBUF[2]),
        .I5(wb_ack_o_OBUF),
        .O(wb_ack_o_i_1_n_0));
  FDRE wb_ack_o_reg
       (.C(wb_clk_i_IBUF_BUFG),
        .CE(\<const1> ),
        .D(wb_ack_o_i_1_n_0),
        .Q(wb_ack_o_OBUF),
        .R(wb_rst_i_IBUF));
  IBUF \wb_adr_i_IBUF[2]_inst 
       (.I(wb_adr_i[2]),
        .O(wb_adr_i_IBUF[2]));
  IBUF \wb_adr_i_IBUF[3]_inst 
       (.I(wb_adr_i[3]),
        .O(wb_adr_i_IBUF[3]));
  IBUF \wb_adr_i_IBUF[4]_inst 
       (.I(wb_adr_i[4]),
        .O(wb_adr_i_IBUF[4]));
  IBUF \wb_adr_i_IBUF[5]_inst 
       (.I(wb_adr_i[5]),
        .O(wb_adr_i_IBUF[5]));
  IBUF \wb_adr_i_IBUF[6]_inst 
       (.I(wb_adr_i[6]),
        .O(wb_adr_i_IBUF[6]));
  IBUF \wb_adr_i_IBUF[7]_inst 
       (.I(wb_adr_i[7]),
        .O(wb_adr_i_IBUF[7]));
  IBUF \wb_bte_i_IBUF[0]_inst 
       (.I(wb_bte_i[0]),
        .O(wb_bte_i_IBUF[0]));
  IBUF \wb_bte_i_IBUF[1]_inst 
       (.I(wb_bte_i[1]),
        .O(wb_bte_i_IBUF[1]));
  BUFG wb_clk_i_IBUF_BUFG_inst
       (.I(wb_clk_i_IBUF),
        .O(wb_clk_i_IBUF_BUFG));
  IBUF wb_clk_i_IBUF_inst
       (.I(wb_clk_i),
        .O(wb_clk_i_IBUF));
  IBUF \wb_cti_i_IBUF[0]_inst 
       (.I(wb_cti_i[0]),
        .O(wb_cti_i_IBUF[0]));
  IBUF \wb_cti_i_IBUF[1]_inst 
       (.I(wb_cti_i[1]),
        .O(wb_cti_i_IBUF[1]));
  IBUF \wb_cti_i_IBUF[2]_inst 
       (.I(wb_cti_i[2]),
        .O(wb_cti_i_IBUF[2]));
  IBUF wb_cyc_i_IBUF_inst
       (.I(wb_cyc_i),
        .O(wb_cyc_i_IBUF));
  IBUF \wb_dat_i_IBUF[0]_inst 
       (.I(wb_dat_i[0]),
        .O(wb_dat_i_IBUF[0]));
  IBUF \wb_dat_i_IBUF[10]_inst 
       (.I(wb_dat_i[10]),
        .O(wb_dat_i_IBUF[10]));
  IBUF \wb_dat_i_IBUF[11]_inst 
       (.I(wb_dat_i[11]),
        .O(wb_dat_i_IBUF[11]));
  IBUF \wb_dat_i_IBUF[12]_inst 
       (.I(wb_dat_i[12]),
        .O(wb_dat_i_IBUF[12]));
  IBUF \wb_dat_i_IBUF[13]_inst 
       (.I(wb_dat_i[13]),
        .O(wb_dat_i_IBUF[13]));
  IBUF \wb_dat_i_IBUF[14]_inst 
       (.I(wb_dat_i[14]),
        .O(wb_dat_i_IBUF[14]));
  IBUF \wb_dat_i_IBUF[15]_inst 
       (.I(wb_dat_i[15]),
        .O(wb_dat_i_IBUF[15]));
  IBUF \wb_dat_i_IBUF[16]_inst 
       (.I(wb_dat_i[16]),
        .O(wb_dat_i_IBUF[16]));
  IBUF \wb_dat_i_IBUF[17]_inst 
       (.I(wb_dat_i[17]),
        .O(wb_dat_i_IBUF[17]));
  IBUF \wb_dat_i_IBUF[18]_inst 
       (.I(wb_dat_i[18]),
        .O(wb_dat_i_IBUF[18]));
  IBUF \wb_dat_i_IBUF[19]_inst 
       (.I(wb_dat_i[19]),
        .O(wb_dat_i_IBUF[19]));
  IBUF \wb_dat_i_IBUF[1]_inst 
       (.I(wb_dat_i[1]),
        .O(wb_dat_i_IBUF[1]));
  IBUF \wb_dat_i_IBUF[20]_inst 
       (.I(wb_dat_i[20]),
        .O(wb_dat_i_IBUF[20]));
  IBUF \wb_dat_i_IBUF[21]_inst 
       (.I(wb_dat_i[21]),
        .O(wb_dat_i_IBUF[21]));
  IBUF \wb_dat_i_IBUF[22]_inst 
       (.I(wb_dat_i[22]),
        .O(wb_dat_i_IBUF[22]));
  IBUF \wb_dat_i_IBUF[23]_inst 
       (.I(wb_dat_i[23]),
        .O(wb_dat_i_IBUF[23]));
  IBUF \wb_dat_i_IBUF[24]_inst 
       (.I(wb_dat_i[24]),
        .O(wb_dat_i_IBUF[24]));
  IBUF \wb_dat_i_IBUF[25]_inst 
       (.I(wb_dat_i[25]),
        .O(wb_dat_i_IBUF[25]));
  IBUF \wb_dat_i_IBUF[26]_inst 
       (.I(wb_dat_i[26]),
        .O(wb_dat_i_IBUF[26]));
  IBUF \wb_dat_i_IBUF[27]_inst 
       (.I(wb_dat_i[27]),
        .O(wb_dat_i_IBUF[27]));
  IBUF \wb_dat_i_IBUF[28]_inst 
       (.I(wb_dat_i[28]),
        .O(wb_dat_i_IBUF[28]));
  IBUF \wb_dat_i_IBUF[29]_inst 
       (.I(wb_dat_i[29]),
        .O(wb_dat_i_IBUF[29]));
  IBUF \wb_dat_i_IBUF[2]_inst 
       (.I(wb_dat_i[2]),
        .O(wb_dat_i_IBUF[2]));
  IBUF \wb_dat_i_IBUF[30]_inst 
       (.I(wb_dat_i[30]),
        .O(wb_dat_i_IBUF[30]));
  IBUF \wb_dat_i_IBUF[31]_inst 
       (.I(wb_dat_i[31]),
        .O(wb_dat_i_IBUF[31]));
  IBUF \wb_dat_i_IBUF[3]_inst 
       (.I(wb_dat_i[3]),
        .O(wb_dat_i_IBUF[3]));
  IBUF \wb_dat_i_IBUF[4]_inst 
       (.I(wb_dat_i[4]),
        .O(wb_dat_i_IBUF[4]));
  IBUF \wb_dat_i_IBUF[5]_inst 
       (.I(wb_dat_i[5]),
        .O(wb_dat_i_IBUF[5]));
  IBUF \wb_dat_i_IBUF[6]_inst 
       (.I(wb_dat_i[6]),
        .O(wb_dat_i_IBUF[6]));
  IBUF \wb_dat_i_IBUF[7]_inst 
       (.I(wb_dat_i[7]),
        .O(wb_dat_i_IBUF[7]));
  IBUF \wb_dat_i_IBUF[8]_inst 
       (.I(wb_dat_i[8]),
        .O(wb_dat_i_IBUF[8]));
  IBUF \wb_dat_i_IBUF[9]_inst 
       (.I(wb_dat_i[9]),
        .O(wb_dat_i_IBUF[9]));
  OBUF \wb_dat_o_OBUF[0]_inst 
       (.I(wb_dat_o_OBUF[0]),
        .O(wb_dat_o[0]));
  OBUF \wb_dat_o_OBUF[10]_inst 
       (.I(wb_dat_o_OBUF[10]),
        .O(wb_dat_o[10]));
  OBUF \wb_dat_o_OBUF[11]_inst 
       (.I(wb_dat_o_OBUF[11]),
        .O(wb_dat_o[11]));
  OBUF \wb_dat_o_OBUF[12]_inst 
       (.I(wb_dat_o_OBUF[12]),
        .O(wb_dat_o[12]));
  OBUF \wb_dat_o_OBUF[13]_inst 
       (.I(wb_dat_o_OBUF[13]),
        .O(wb_dat_o[13]));
  OBUF \wb_dat_o_OBUF[14]_inst 
       (.I(wb_dat_o_OBUF[14]),
        .O(wb_dat_o[14]));
  OBUF \wb_dat_o_OBUF[15]_inst 
       (.I(wb_dat_o_OBUF[15]),
        .O(wb_dat_o[15]));
  OBUF \wb_dat_o_OBUF[16]_inst 
       (.I(wb_dat_o_OBUF[16]),
        .O(wb_dat_o[16]));
  OBUF \wb_dat_o_OBUF[17]_inst 
       (.I(wb_dat_o_OBUF[17]),
        .O(wb_dat_o[17]));
  OBUF \wb_dat_o_OBUF[18]_inst 
       (.I(wb_dat_o_OBUF[18]),
        .O(wb_dat_o[18]));
  OBUF \wb_dat_o_OBUF[19]_inst 
       (.I(wb_dat_o_OBUF[19]),
        .O(wb_dat_o[19]));
  OBUF \wb_dat_o_OBUF[1]_inst 
       (.I(wb_dat_o_OBUF[1]),
        .O(wb_dat_o[1]));
  OBUF \wb_dat_o_OBUF[20]_inst 
       (.I(wb_dat_o_OBUF[20]),
        .O(wb_dat_o[20]));
  OBUF \wb_dat_o_OBUF[21]_inst 
       (.I(wb_dat_o_OBUF[21]),
        .O(wb_dat_o[21]));
  OBUF \wb_dat_o_OBUF[22]_inst 
       (.I(wb_dat_o_OBUF[22]),
        .O(wb_dat_o[22]));
  OBUF \wb_dat_o_OBUF[23]_inst 
       (.I(wb_dat_o_OBUF[23]),
        .O(wb_dat_o[23]));
  OBUF \wb_dat_o_OBUF[24]_inst 
       (.I(wb_dat_o_OBUF[24]),
        .O(wb_dat_o[24]));
  OBUF \wb_dat_o_OBUF[25]_inst 
       (.I(wb_dat_o_OBUF[25]),
        .O(wb_dat_o[25]));
  OBUF \wb_dat_o_OBUF[26]_inst 
       (.I(wb_dat_o_OBUF[26]),
        .O(wb_dat_o[26]));
  OBUF \wb_dat_o_OBUF[27]_inst 
       (.I(wb_dat_o_OBUF[27]),
        .O(wb_dat_o[27]));
  OBUF \wb_dat_o_OBUF[28]_inst 
       (.I(wb_dat_o_OBUF[28]),
        .O(wb_dat_o[28]));
  OBUF \wb_dat_o_OBUF[29]_inst 
       (.I(wb_dat_o_OBUF[29]),
        .O(wb_dat_o[29]));
  OBUF \wb_dat_o_OBUF[2]_inst 
       (.I(wb_dat_o_OBUF[2]),
        .O(wb_dat_o[2]));
  OBUF \wb_dat_o_OBUF[30]_inst 
       (.I(wb_dat_o_OBUF[30]),
        .O(wb_dat_o[30]));
  OBUF \wb_dat_o_OBUF[31]_inst 
       (.I(wb_dat_o_OBUF[31]),
        .O(wb_dat_o[31]));
  OBUF \wb_dat_o_OBUF[3]_inst 
       (.I(wb_dat_o_OBUF[3]),
        .O(wb_dat_o[3]));
  OBUF \wb_dat_o_OBUF[4]_inst 
       (.I(wb_dat_o_OBUF[4]),
        .O(wb_dat_o[4]));
  OBUF \wb_dat_o_OBUF[5]_inst 
       (.I(wb_dat_o_OBUF[5]),
        .O(wb_dat_o[5]));
  OBUF \wb_dat_o_OBUF[6]_inst 
       (.I(wb_dat_o_OBUF[6]),
        .O(wb_dat_o[6]));
  OBUF \wb_dat_o_OBUF[7]_inst 
       (.I(wb_dat_o_OBUF[7]),
        .O(wb_dat_o[7]));
  OBUF \wb_dat_o_OBUF[8]_inst 
       (.I(wb_dat_o_OBUF[8]),
        .O(wb_dat_o[8]));
  OBUF \wb_dat_o_OBUF[9]_inst 
       (.I(wb_dat_o_OBUF[9]),
        .O(wb_dat_o[9]));
  OBUF wb_err_o_OBUF_inst
       (.I(\<const0> ),
        .O(wb_err_o));
  IBUF wb_rst_i_IBUF_inst
       (.I(wb_rst_i),
        .O(wb_rst_i_IBUF));
  IBUF \wb_sel_i_IBUF[0]_inst 
       (.I(wb_sel_i[0]),
        .O(wb_sel_i_IBUF[0]));
  IBUF \wb_sel_i_IBUF[1]_inst 
       (.I(wb_sel_i[1]),
        .O(wb_sel_i_IBUF[1]));
  IBUF \wb_sel_i_IBUF[2]_inst 
       (.I(wb_sel_i[2]),
        .O(wb_sel_i_IBUF[2]));
  IBUF \wb_sel_i_IBUF[3]_inst 
       (.I(wb_sel_i[3]),
        .O(wb_sel_i_IBUF[3]));
  IBUF wb_stb_i_IBUF_inst
       (.I(wb_stb_i),
        .O(wb_stb_i_IBUF));
  IBUF wb_we_i_IBUF_inst
       (.I(wb_we_i),
        .O(wb_we_i_IBUF));
endmodule
