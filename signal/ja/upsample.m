%UPSAMPLE  信号入力をアンプサンプリング
%
%   UPSAMPLE(X,N) は、入力サンプルの間に N-1 の 0 を挿入することにで、
%   入力信号 X をアップサンプリングします。X は、ベクトル、あるいは、
%   (1 列につき 1 つの信号をもつ) 信号行列のいずれかです。
%
%   UPSAMPLE(X,N,PHASE) は、オプションのサンプルオフセットを指定します。
%   PHASE は、[0, N-1] の範囲の整数でなければなりません。
%
%   参考 DOWNSAMPLE, UPFIRDN, INTERP, DECIMATE, RESAMPLE.


%   Copyright 1988-2007 The MathWorks, Inc.
