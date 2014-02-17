%LP2BS  ローパスフィルタプロトタイプをバンドストップアナログフィルタへ変換
%
%   [NUMT,DENT] = LP2BS(NUM,DEN,Wo,Bw) は、単位カットオフ周波数をもつ
%   アナログローパスフィルタのプロトタイプ NUM(s)/DEN(s) を帯域幅 Bw と
%   カットオフ周波数 Wo をもつバンドストップフィルタに変換します。
%   [AT,BT,CT,DT] = LP2BS(A, B,C,D,Wo,Bw) は、フィルタが状態空間型で記述
%   される場合、同じものに変換します。
%
%   参考 BILINEAR, IMPINVAR, LP2BP, LP2LP, LP2HP


%   Copyright 1988-2007 The MathWorks, Inc.
