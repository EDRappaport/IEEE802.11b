%HALFRANGE  ナイキスト間隔の半分で計算されたスペクトル
%
%   HALFRANGE(H) は、データオブジェクト (<a href="matlab:help dspdata">dspdata</a>) 
%   H で指定されたパワースペクトルを半分のナイキスト区間で計算されたスペクトルに
%   変換します。Frequencies や SpectrumRange のように関連するプロパティは、新規の
%   周波数範囲に反映するために更新されます。
%
%   注意:データの対称性を保証するためにチェックを行いません。すなわち、スペクトルは
%   実数信号であり、それゆえデータ点数の半分のみ使われているものと仮定します。
%
%   参考 DSPDATA, SPECTRUM.


%   Copyright 1988-2007 The MathWorks, Inc.
