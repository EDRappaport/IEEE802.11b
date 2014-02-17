%SS  離散時間フィルタを状態空間に変換
%
%   [A,B,C,D] = SS(Hd) は、離散時間フィルタ Hd を下記で与えられる状態空間に
%   変換します。
%     x(k+1) = A*x(k) + B*u(k)
%     y(k)   = C*x(k) + D*u(k)
%   ここで、x は状態ベクトルで、u は入力ベクトル、y は出力ベクトルです。


%   Copyright 1988-2007 The MathWorks, Inc.
