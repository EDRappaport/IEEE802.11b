%DOWNSAMPLE  信号入力をダウンサンプリング
%
%   DOWNSAMPLE(X,N) は、すべての N-番目のサンプルを最初のものとして、
%   始めることで、入力信号 X のダウンサンプリングを行います。X が行列の
%   場合、ダウンサンプリングは、X の列に沿って行われます。
%
%   DOWNSAMPLE(X,N,PHASE) は、オプションのサンプルのオフセットを指定します。
%   PHASE は、[0, N-1] の範囲の整数でなければなりません。
%
%   参考 UPSAMPLE, UPFIRDN, INTERP, DECIMATE, RESAMPLE.


%   Copyright 1988-2007 The MathWorks, Inc.
