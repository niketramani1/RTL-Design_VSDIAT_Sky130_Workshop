/* Generated by Yosys 0.9+4081 (git sha1 862e84eb, gcc 7.5.0-3ubuntu1~18.04 -fPIC -Os) */

module bad_case(i0, i1, i2, i3, sel, y);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  input i0;
  input i1;
  input i2;
  input i3;
  input [1:0] sel;
  output y;
  sky130_fd_sc_hd__mux4_2 _16_ (
    .A0(_09_),
    .A1(_10_),
    .A2(_11_),
    .A3(_12_),
    .S0(_13_),
    .S1(_14_),
    .X(_15_)
  );
  assign _14_ = sel[1];
  assign _13_ = sel[0];
  assign _11_ = i2;
  assign _10_ = i1;
  assign _09_ = i0;
  assign _12_ = i3;
  assign y = _15_;
endmodule
