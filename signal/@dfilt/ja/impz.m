%IMPZ  離散時間フィルタのインパルス応答
%
%   [H,T] = IMPZ(Hd) は、ユーザが選択したサンプル数の離散時間フィルタ 
%   Hd のインパルス応答を計算し、列ベクトル H の応答と、T (T = [0 1 2...]') 
%   の時間 (またはサンプル間隔) のベクトルを返します。
%
%   [H,T] = IMPZ(Hd) は、Hd がベクトルの場合、行列を返します。STEPZ(Hd) は、
%   Filter Visualization Tool (FVTool) のステップ応答を表示します。
%
%   追加パラメータについては、SIGNAL/IMPZ を参照してください。
%
%   参考 DFILT, SIGNAL/IMPZ.


%   Copyright 1988-2007 The MathWorks, Inc.
