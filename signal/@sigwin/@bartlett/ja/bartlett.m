%BARTLETT  Bartlett ウィンドウ
%
%   H = SIGWIN.BARTLETT(N) は、N 点の Bartlett ウィンドウオブジェクト H を
%   返します。
%
%   例:
%     N = 64;
%     h = sigwin.bartlett(N);
%     w = generate(h);
%     stem(w); title('64-point Bartlettwindow');
%
%   参考 SIGWIN.


%   Copyright 1988-2008 The MathWorks, Inc.
