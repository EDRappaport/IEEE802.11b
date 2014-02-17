%LP2HP  ローパスフィルタプロトタイプをハイパスアナログフィルタへ変換
%
%   [NUMT,DENT] = LP2HP(NUM,DEN,Wo) は、単位カットオフ周波数をもつローパス
%   フィルタのプロトタイプ NUM(s)/DEN(s) をカットオフ周波数 Wo をもつ
%   ハイパスフィルタに変換します。
%   [AT,BT,CT,DT] = LP2HP(A,B,C,D,Wo) は、フィルタが状態空間型で記述される
%   場合、同じものに変換します。
%
%   参考 BILINEAR, IMPINVAR, LP2BP, LP2BS and LP2LP


%   Copyright 1988-2007 The MathWorks, Inc.
