%ONESIDED  ナイキスト間隔の半分で計算されたスペクトル
%
%   ONESIDED(H) は、データオブジェクト (<a href="matlab:help dspdata">dspdata</a>) 
%   H で指定されたパワースペクトルをすべてのパワーを含む半分のナイキスト区間で
%   計算されたスペクトルに変換します。Frequencies や SpectrumType のように
%   関連するプロパティは、新規の周波数範囲に反映するために更新されます。
%
%   注意:データの対称性を保証するためにチェックを行いません。すなわち、スペクトル
%   は実数信号であり、それゆえデータ点数の半分のみ使われている ものと仮定します。
%
%   参考 DSPDATA, SPECTRUM.


%   Copyright 1988-2007 The MathWorks, Inc.
