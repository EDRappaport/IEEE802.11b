%IIRLP2XN  IIR ローパスを N 点周波数に変換
%
%   [G, ANUM, ADEN] = IIRLP2XN(H,Wo,Wt,DC) は、オリジナル周波数 Wo と
%   ターゲット周波数 Wt に対する変換されたフィルタ G を返します。すべての
%   帯域をマッピングするフィルタは、分子ベクトル ANUM と分母ベクトル ADEN に
%   返されます。DC は、DC での帯域を指定する文字列 'pass' または 'stop' で、
%   'pass' がデフォルトです。
%
%   参考 FILTERDESIGN/IIRLP2XN.


%   Copyright 1988-2007 The MathWorks, Inc.
