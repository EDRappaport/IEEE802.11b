%VALIDSTRUCTURES  有効な構造を出力
%
%   VALIDSTRUCTURES(D, METHOD) は、文字列のセル配列に、オブジェクト D と
%   設計メソッド METHOD に対する有効な構造を返します。
%
%   % 例
%   h = fdesign.lowpass;
%   validstructures(h, 'equiripple')
%
%   参考 FDESIGN/DESIGNMETHODS, FDESIGN/DESIGNOPTS.


% Copyright 2004-2008 The MathWorks, Inc.

