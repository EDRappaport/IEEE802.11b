%ARBURG  Burg 法を使った、AR モデルパラメータの推定
%
%   A = ARBURG(X,ORDER) は、Burg 法を使って、入力信号 (X) に適合する
%   自己回帰  (AR) モデルの AR モデルパラメータ (A) を計算します。ORDER は、
%   AR システムの次数です。
%
%   [A,E] = ARBURG(...) は、最終予測誤差 E (AR モデルに白色ノイズ入力を
%   行ったときの分散) を返します。
%
%   [A,E,K] = ARBURG(...) は、反射係数 (parcor 係数) のベクトル K を返します。
%
%   参考 PBURG, ARMCOV, ARCOV, ARYULE, LPC, PRONY.


%   Copyright 1988-2007 The MathWorks, Inc.
