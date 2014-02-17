%ARYULE  Yule-Walker 法を使って、AR モデルパラメータの推定
%
%   A = ARYULE(X,ORDER) は、Yule-Walker (自己相関) 法を使って、入力信号 
%   X に適合する自己回帰 AR モデルの AR モデルパラメータ A を計算します。
%   ORDER は、AR システムの次数です。この方法は、Levinson-Durbin 再帰法を
%   使って、Yule-Walker 方程式を解くものです。
%
%   [A,E] = ARYULE(...) は、最終予測誤差 (AR モデルへの白色ノイズ入力の
%   結果の分散 E) を返します。
%
%   [A,E,K] = ARYULE(...) は、反射係数ベクトル K を返します。
%
%   参考 PYULEAR, ARMCOV, ARBURG, ARCOV, LPC, PRONY.


%   Copyright 1988-2007 The MathWorks, Inc.
