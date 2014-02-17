%FREQZ  離散時間フィルタの周波数応答
%
%   [H,W] = FREQZ(Hd,N) は、離散時間フィルタ Hd の N 点の複素周波数応答
%   ベクトル H とラジアン/サンプルの N 点の周波数ベクトル W を返します。
%   周波数応答は、単位円の上半分の等間隔な N 点を評価します。N を指定
%   しない場合、デフォルトは 8192 です。
%
%   FREQZ(Hd) として出力引数をもたない場合、振幅応答と位相応答をもつ 
%   FVTool を起動します。
%
%   [H,W] = FREQZ(Hd) は、Hd がベクトルの場合、行列 H を返します。
%   STEPZ(Hd) は、Filter Visualization Tool(FVTool) のステップ応答を
%   表示します。周波数の行ベクトルが指定された場合、行列の各行は各フィルタ
%   のベクトルに対応します。
%
%   追加パラメータについては、SIGNAL/FREQZ を参照してください。
%
%   参考 DFILT, SIGNAL/FREQZ, FVTOOL.


% Copyright 1988-2007 The MathWorks, Inc.
