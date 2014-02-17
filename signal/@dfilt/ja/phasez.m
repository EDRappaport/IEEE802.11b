%PHASEZ  離散時間フィルタの位相応答 (unwrapped)
%
%   [Phi,W] = PHASEZ(Hd,N) は、離散時間フィルタ Hd の位相応答 Phi とその点で
%   評価した (ラジアンの) 周波数点 W を含むベクトルを返します。位相応答は
%   単位円の約上半分の N 点の等間隔な空間で評価されます。N を指定しない場合、
%   デフォルトは 8192 です。
%
%   Hd がフィルタオブジェクトのベクトルの場合、Phi は行列になります。
%   STEPZ(Hd) は、Filter Visualization Tool (FVTool) のステップ応答を
%   表示します。周波数の行ベクトルが指定された場合、行列の各行は各フィルタの
%   ベクトルに対応します。
%
%   PHASEZ(Hd) は、Filter Visualization Tool (FVTool) の位相応答を表示します。
%
%   追加パラメータに関しては、SIGNAL/PHASEZ を参照してください。


%   Copyright 1988-2007 The MathWorks, Inc.
