%CCONV  N を法とする巡回畳み込み
%
%   C = CCONV(A, B, N) は、ベクトル A と B の巡回畳み込みを行います。結果の
%   ベクトルは、長さ N です。省略された場合、N は、デフォルトで 
%   LENGTH(A)+LENGTH(B)-1 です。N = LENGTH(A)+LENGTH(B)-1 の場合、
%   巡回畳み込みは、CONV で計算される線形畳み込みと等価になります。
%
%   % 例 #1: 4 を法とする巡回畳み込み
%   a = [2 1 2 1];
%   b = [1 2 3 4];
%   c = cconv(a,b,4)
%
%   % 例 #2: より高速な線形畳み込みとしての巡回畳み込み
%   a = [1 2 -1 1];
%   b = [1 1 2 1 2 2 1 1];
%   c = cconv(a,b,11)
%   cref = conv(a,b)
%
%   % 例 #3: 巡回的な相互相関
%   a = [1 2 2 1]+i;
%   b = [1 3 4 1]-2*i;
%   c = cconv(a,conj(fliplr(b)),7)
%   cref = xcorr(a,b)
%
%   参考 CONV, XCORR


%   Copyright 2006-2007 The MathWorks, Inc.
