%STMCB  Steiglitz-McBride 反復法を使って、線形モデルを計算
%
%   [B,A] = stmcb(H,NB,NA) は、インパルス応答 H を NA 個の極、NB 個の零点を
%   もつシステム B(Z)/A(Z) で近似したシステムの係数をもちます。
%
%   [B,A] = stmcb(H,NB,NA,N) は、N 回の反復を行います。N のデフォルトは 5 です。
%
%   [B,A] = stmcb(H,NB,NA,N,Ai) は、分母係数の初期推定値としてベクトル Ai を
%   使用します。Ai を設定しない場合、STMCB は、[B,Ai] = PRONY(H,0,NA) の出力
%   引数をベクトル Ai として使用します。
%
%   [B,A] = STMCB(Y,X,NB,NA,N,Ai) は、入力として X が与えられ、出力として 
%   Y をもつシステムのシステム係数 B および A を求めます。N と Ai は、N = 5, 
%   [B, Ai]= PRONY(Y,0,NA) のデフォルト値を使って求めます。Y と X は同じ長さで
%   なければなりません。
%
%   参考 PRONY, LEVINSON, LPC, ARYULE.


%   Copyright 1988-2007 The MathWorks, Inc.
