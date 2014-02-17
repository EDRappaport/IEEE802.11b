%RC2POLY  反射係数を予測多項式へ (徐々に) 変換
%
%   A = RC2POLY(K) は、反射係数 K に基づき、予測多項式 A を計算します。
%
%   [A,Efinal] = RC2POLY(K,R0) は、ゼロラグの自己相関係数 R0 に基づき、
%   最終予測誤差 Efinal を返します。
%
%   参考 POLY2RC, RC2AC, AC2RC, AC2POLY, POLY2AC.


%   Copyright 1988-2007 The MathWorks, Inc.
