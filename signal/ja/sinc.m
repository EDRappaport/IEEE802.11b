%SINC  Sin(pi*x)/(pi*x) 関数
%
%   SINC(X) は、その要素が X の要素の sinc となる行列を返します。すなわち、
%   sinc 関数は、つぎのように表されます。
%        y = sin(pi*x)/(pi*x)    x ~= 0 の場合
%          = 1                   x == 0 の場合
%   ここで x は入力行列の要素で、y は結果の出力要素です。
%
%   % 線形間隔のベクトルに対する sinc 関数の例:
%   t = linspace(-5,5);
%   y = sinc(t);
%   plot(t,y);
%   xlabel('Time (sec)');ylabel('Amplitude'); title('Sinc Function')
%
%   参考 SQUARE, SIN, COS, CHIRP, DIRIC, GAUSPULS, PULSTRAN, RECTPULS, TRIPULS.


%   Copyright 1988-2007 The MathWorks, Inc.
