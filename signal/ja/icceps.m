%ICCEPS  逆複素ケプストラム
%
%   ICCEPS(XHAT,ND) は、遅延分 ND サンプルを除去した実数列 XHAT の逆複素
%   ケプストラムを返します。XHAT が、CCEPS(X) で得られた場合、X に付加
%   された遅延総量は、πラジアンに相当する round(unwrap(angle(fft(x)))/pi) 
%   の要素になります。
%
%   例:逆複素ケプストラムを計算するために ICCEPS を使用します。
%   x = 1:10;
%   [xh,nd] = cceps(x);
%   % 複素ケプストラムの逆操作を行う icceps で遅延パラメータを使用します。
%   icceps(xh,nd)
%
%   参考 CCEPS, RCEPS, HILBERT, FFT.


%   Copyright 1988-2007 The MathWorks, Inc.
