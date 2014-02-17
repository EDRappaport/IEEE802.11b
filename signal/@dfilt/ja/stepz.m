%STEPZ  離散時間フィルタのステップ応答
%
%   [H,T] = STEPZ(Hd) は、離散時間フィルタ Hd のステップ応答 H を返します。
%   列ベクトル H の長さは、IMPZLENGTH を使って計算されます。評価された 
%   S での時間サンプルのベクトルは、ベクトル T に返されます。
%
%   [H,T] = STEPZ(Hd) は、Hd がベクトルの場合、行列を返します。STEPZ(Hd) は、
%   Filter Visualization Tool (FVTool) のステップ応答を表示します。
%
%   STEPZ(Hd) は、Filter Visualization Tool (FVTool) のステップ応答を
%   表示します。
%
%   追加パラメータについては、SIGNAL/STEPZ を参照してください。
%
%   参考 DFILT/IMPZ, DFILT/FREQZ.


%   Copyright 1988-2007 The MathWorks, Inc.
