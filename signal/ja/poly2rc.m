%POLY2RC  予測多項式を反射係数へ変換
%
%   K = POLY2RC(A) は、予測多項式 A に基づき、反射係数 K を返します。
%
%   A(1) が 1 と等しくない場合、POLY2RC は、A(1) で予測多項式を正規化します。
%
%   [K,R0] = POLY2RC(A,Efinal) は、最終予測誤差 Efinal に基づき、ゼロラグの
%   自己相関係数 R0 を返します。Efinal が指定されない場合、デフォルトは 
%   Efinal=0 です。
%
%   参考 RC2POLY, POLY2AC, AC2POLY, RC2AC, AC2RC, TF2LATC.


%   Copyright 1988-2007 The MathWorks, Inc.
