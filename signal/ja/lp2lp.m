%LP2LP  ローパスフィルタプロトタイプをローパスアナログフィルタへ変換
%
%   [NUMT,DENT] = LP2LP(NUM,DEN,Wo) は、単位カットオフ周波数をもつローパス
%   フィルタのプロトタイプ NUM(s)/DEN(s) をカットオフ周波数 Wo(rad/sec) を
%   もつローパスフィルタに変換します。[AT,BT,CT,DT] = LP2LP(A,B,C,D,Wo) は、
%   フィルタが状態空間型で記述される場合、同じものに変換します。
%
%   参考 BILINEAR, IMPINVAR, LP2BP, LP2BS, LP2HP


%   Copyright 1988-2007 The MathWorks, Inc.
