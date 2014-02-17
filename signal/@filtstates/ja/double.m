%DOUBLE  FILTSTATES.DFIIR オブジェクトを double のベクトルに変換
%
%   DOUBLE(Hs) は、FILTSTATES.DFIIR オブジェクトに対する倍精度値を返します。
%
%   例:
%   [b,a] = butter(4,.5);
%   Hd = dfilt.df1(b,a);
%   hs = Hd.states; % FILTSTATES.DFIIR オブジェクトを返す
%   dblstates = double(hs); % オブジェクトを double のベクトルに変換
%
%   参考 FILTSTATES/DFIIR, DFILT.


%   Copyright 1988-2007 The MathWorks, Inc.
