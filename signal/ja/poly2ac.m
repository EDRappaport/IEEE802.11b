%POLY2AC  予測多項式を自己相関列に変換
%
%   R = POLY2AC(A,Efinal) は、予測多項式 A と最終予測誤差 Efinal に基づき、
%   自己相関列 R を返します。
%
%   A(1) が 1 と等しくない場合、POLY2AC は、A(1) で予測多項式を正規化します。
%
%   参考 AC2POLY, POLY2RC, RC2POLY, RC2AC, AC2RC.


%   Copyright 1988-2007 The MathWorks, Inc.
