%PRONY  時間領域 IIR フィルタ設計のための Prony 法
%
%   [B,A] = PRONY(H, NB, NA) は、ベクトル H 内のインパルス応答を使って、
%   分子の次数 NB と分母の次数 NA をもつフィルタを求めます。PRONY は、
%   長さ NB+1 および NA+1 のフィルタ係数を行ベクトル B および A にそれぞれ
%   返します。フィルタ係数は、Z の次数の降順です。H は、実数でも複素数でも
%   構いません。
%
%   指定した最大次数が、H の長さより大きい場合、H は、0 で埋められます。
%
%   参考 STMCB, LPC, BUTTER, CHEBY1, CHEBY2, ELLIP, INVFREQZ.


%   Copyright 1988-2007 The MathWorks, Inc.
