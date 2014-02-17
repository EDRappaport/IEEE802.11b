%CZT  Chirp-z 変換
%
%   G = CZT(X, M, W, A) は、信号 X の M 要素の z 変換です。ここで、M, W, A は、
%   スカラ値で、計算される z-変換の平面上の等高線図 z を設定します。M は
%   変換の長さで、W は等高線図上での点間の複雑さを示す比率、スカラ A は、
%   その等高線図上の出発点を与える複素数です。より明確には、z 平面の等高線図 
%   (螺旋、または "chip" の等高線) は、次式で記述されます。
%       z = A * W.^(-(0:M-1))
%
%   パラメータM, W, Aは、つぎのデフォルト値を使用します。M = length(X), 
%   W = exp(-j*2*pi/M), A = 1.これらのデフォルト値を使用して、CZT は、
%   単位円周上の等間隔の M 点での X の Z 変換を返します。これは、FFT(X) と
%   等価です。
%
%   X が行列の場合、chirp z 変換は、X の各列を変換します。
%
%   参考 FFT, FREQZ.


%   Copyright 1988-2007 The MathWorks, Inc.
