%FLATTOPWIN  Flat Top ウィンドウ
%
%   FLATTOPWIN(N) は、N 点の対称 Flat Top ウィンドウを列ベクトルに返します。
%   FLATTOPWIN(N,SFLAG) は、SFLAG ウィンドウサンプリングを使って N 点の 
%   Flat Top ウィンドウを生成します。SFLAG は、'symmetric' または 'periodic' 
%   のいずれかになります。デフォルトでは、対称なウインドウが使われます。
%
%   例:
%      w = flattopwin(64);
%      wvtool(w);
%
%   参考 BARTHANNWIN, BARTLETT, BLACKMANHARRIS, BOHMANWIN,
%        NUTTALLWIN, PARZENWIN, RECTWIN, TRIANG, WINDOW.


%   Copyright 1988-2007 The MathWorks, Inc.
