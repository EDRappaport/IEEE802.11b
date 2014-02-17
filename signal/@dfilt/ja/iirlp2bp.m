%IIRLP2BP  IIR ローパスをバンドパス周波数に変換
%
%   [G, ANUM, ADEN] = IIRLP2BP(H,Wo,Wt) は、オリジナル周波数 Wo とターゲット
%   周波数 Wt に対する変換されたフィルタ G を返します。すべての帯域をマッピング
%   するフィルタは、分子ベクトル ANUM と分母ベクトル ADEN に返されます。
%
%   参考 FILTERDESIGN/IIRLP2BP.


%   Copyright 1988-2007 The MathWorks, Inc.
