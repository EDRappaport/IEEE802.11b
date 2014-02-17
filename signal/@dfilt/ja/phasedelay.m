% PHASEDELAY   デジタルフィルタの位相遅延
%
% [PHI,W] = PHASEDELAY(Hd,N) は、N-点位相遅延応答のベクトル PHI と
% フィルタの radians/sample での N-点周波数ベクトル W を出力します。
% 位相応答は、単位円の上半分の周りに等間隔の N点で評価されます。
% N を指定しない場合、デフォルトは 8192 です。
%
% Hd がフィルタオブジェクトのベクトルの場合、Phi は行列になります。
% 行列の各列は、ベクトル内の各フィルタに対応します。周波数点の行ベクトルが
% 指定されたばあい、行列の各行は、ベクトル内の各フィルタに対応します。
%
% PHASEDELAY(Hd) は、Filter Visualization Tool (FVTool) で位相遅延応答を
% 表示します。
%
% 追加のパラメータについては、SIGNAL/PHASEDELAY を参照してください。
%
%   参考 DFILT, SIGNAL/PHASEDELAY, FVTOOL.


%   Copyright 1988-2004 The MathWorks, Inc.
