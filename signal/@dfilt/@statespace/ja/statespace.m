%STATESPACE  離散時間状態空間フィルタ
%
%   Hd = DFILT.STATESPACE(A, B, C, D) は、長方形配列 A, B, C, D を持つ
%   離散時間の状態空間フィルタ Hd を作成します。A、B、C、Dは、行列形式
%   または状態-空間形式のフィルタの差分方程式から得られたものです。
%
%   x(n+1) = A*x(n) + B*u(n)
%   y(n)   = C*x(n) + D*u(n)
%
%   ここで、x(n) は、時間 n におけるベクトルの状態です。
%         u(n) は時間 n における入力です。
%         y は、時間 n における出力です。
%         A は、状態遷移行列です。
%         B は、入力から状態への伝送行列です。
%         C は、状態から出力への伝送行列です。
%         D は、入力から出力への伝送行列です。
%
%   A, B, C, D が指定されない場合、デフォルトは [], [], [], 1 です。
%
%   % 例:
%   [A,B,C,D] = butter(2,.5);
%   Hd = dfilt.statespace(A,B,C,D)
%
%   参考 DFILT/STRUCTURES, TF2SS, ZP2SS


%   Copyright 1988-2008 The MathWorks, Inc.
