%RCEPS  実数ケプストラム
%
%   RCEPS(X) は、実数列 X の実数ケプストラムを返します。
%
%   [XHAT, YHAT] = RCEPS(X) は、実数ケプストラム XHAT と、X と同じ実数
%   ケプストラムをもつ固有の最小位相列である YHAT の両方を返します。
%
%   例:YHAT が X と同じ実数ケプストラムをもつ固有の最小位相列であることを
%   示します。
%   y = [4 1 5]; % 非最小位相列
%   [xhat,yhat] = rceps(y);
%   xhat2= rceps(yhat);
%   [xhat' xhat2']
%
%   参考 CCEPS, ICCEPS, HILBERT, FFT.


%   Copyright 1988-2007 The MathWorks, Inc.
