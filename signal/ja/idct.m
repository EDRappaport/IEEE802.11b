%IDCT  逆離散コサイン変換
%
%   X = IDCT(Y) は、DCT 変換の逆変換を行い、データ列 Y が Y = DCT(X) で
%   得られたものである場合、逆変換により、オリジナルの X を復元します。
%
%   X = IDCT(Y,N) は、変換の前にベクトル Y を付加、または切り捨てて、
%   長さ N にします。
%
%   Y が行列の場合、IDCT 演算は、X の各列に適用します。
%
%   参考 FFT, IFFT, DCT.


%   Copyright 1988-2007 The MathWorks, Inc.
