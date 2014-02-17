%DIRIC  Dirichlet 関数または周期的な sinc 関数
%
%   Y = DIRIC(X,N) は、X の要素の Dirichlet 関数を要素とする X と同じ
%   サイズの行列を返します。正の整数 N は、0 から 2*pi までの区間で等間隔で
%   分布する計算する点数です。
%
%   Dirichlet 関数は、つぎのように定義されます。
%       d(x) = sin(N*x/2)./(N*sin(x/2))   x が 2*pi の倍数でなければ +1、
%              または x が 2*pi の倍数であれば -1 になります (範囲に依存します)。


%   Copyright 1988-2007 The MathWorks, Inc.
