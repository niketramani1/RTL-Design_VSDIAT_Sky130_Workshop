/* Generated by Yosys 0.9+4081 (git sha1 862e84eb, gcc 7.5.0-3ubuntu1~18.04 -fPIC -Os) */

module demux_case(o0, o1, o2, o3, o4, o5, o6, o7, sel, i);
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
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire _29_;
  wire _30_;
  wire _31_;
  wire _32_;
  wire _33_;
  wire _34_;
  wire _35_;
  wire _36_;
  wire _37_;
  wire _38_;
  wire _39_;
  wire _40_;
  wire _41_;
  wire _42_;
  wire _43_;
  wire _44_;
  wire _45_;
  wire _46_;
  wire _47_;
  wire _48_;
  input i;
  output o0;
  output o1;
  output o2;
  output o3;
  output o4;
  output o5;
  output o6;
  output o7;
  input [2:0] sel;
  wire [7:0] y_int;
  sky130_fd_sc_hd__and4b_1 _49_ (
    .A_N(_46_),
    .B(_37_),
    .C(_48_),
    .D(_47_),
    .X(_44_)
  );
  sky130_fd_sc_hd__nor4bb_1 _50_ (
    .A(_47_),
    .B(_46_),
    .C_N(_37_),
    .D_N(_48_),
    .Y(_42_)
  );
  sky130_fd_sc_hd__and4b_1 _51_ (
    .A_N(_47_),
    .B(_46_),
    .C(_37_),
    .D(_48_),
    .X(_43_)
  );
  sky130_fd_sc_hd__nor4b_1 _52_ (
    .A(_48_),
    .B(_47_),
    .C(_46_),
    .D_N(_37_),
    .Y(_38_)
  );
  sky130_fd_sc_hd__nor4bb_1 _53_ (
    .A(_48_),
    .B(_47_),
    .C_N(_46_),
    .D_N(_37_),
    .Y(_39_)
  );
  sky130_fd_sc_hd__and4b_1 _54_ (
    .A_N(_48_),
    .B(_47_),
    .C(_46_),
    .D(_37_),
    .X(_41_)
  );
  sky130_fd_sc_hd__nor4bb_1 _55_ (
    .A(_48_),
    .B(_46_),
    .C_N(_37_),
    .D_N(_47_),
    .Y(_40_)
  );
  sky130_fd_sc_hd__and4_1 _56_ (
    .A(_48_),
    .B(_47_),
    .C(_46_),
    .D(_37_),
    .X(_45_)
  );
  assign y_int = { o7, o6, o5, o4, o3, o2, o1, o0 };
  assign _48_ = sel[2];
  assign _47_ = sel[1];
  assign _46_ = sel[0];
  assign _37_ = i;
  assign o6 = _44_;
  assign o4 = _42_;
  assign o5 = _43_;
  assign o0 = _38_;
  assign o1 = _39_;
  assign o3 = _41_;
  assign o2 = _40_;
  assign o7 = _45_;
endmodule
