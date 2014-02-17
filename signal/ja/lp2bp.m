%LP2BP  ローパスフィルタプロトタイプをバンドパスアナログフィルタへ変換
%
%   [NUMT,DENT] = LP2BP(NUM,DEN,Wo,Bw) は、単位カットオフ周波数をもつ
%   アナログローパスフィルタのプロトタイプ NUM(s)/DEN(s) を目的の帯域幅 
%   Bw とカットオフ周波数 Wo をもつバンドパスフィルタに変換します。
%   [AT,BT,CT,DT] = LP2BP(A,B,C,D,Wo,Bw) は、フィルタが状態空間型で記述
%   される場合、同じものに変換します。
%
%   参考 BILINEAR, IMPINVAR, LP2LP, LP2BS, LP2HP


%   Copyright 1988-2007 The MathWorks, Inc.
