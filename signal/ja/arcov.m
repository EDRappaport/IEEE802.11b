%ARCOV  共分散法を使って、AR モデルパラメータの推定
%
%   A = ARCOV(X,ORDER) は、共分散法を使って、入力信号 (X) に適合する
%   自己回帰  (AR) モデルの AR モデルパラメータ (A) を返します。ORDER は、
%   AR システムの次数です。
%
%   [A,E] = ARCOV(...) は、AR モデルへの白色ノイズ入力の分散 (E) を返します。
%
%   参考 PCOV, ARMCOV, ARBURG, ARYULE, LPC, PRONY.


%   Copyright 1988-2007 The MathWorks, Inc.
