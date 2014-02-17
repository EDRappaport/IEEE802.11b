%STRIPS  Strip プロット
%
%   STRIPS(X) は、ベクトル X を長さ 250 の水平的な細長い図 (strip) に
%   プロットします。X が行列の場合、STRIPS(X) は、X の列方向を水平方向の
%   図に表示します。左端の列 (1 列目) が、一番上にある水平方向の図になります。
%
%   STRIPS(X,N) は、ベクトル X をそれぞれが N サンプル長で strips プロット
%   します。
%
%   STRIPS(X,SD,Fs) は、1 秒間に Fs 個のサンプルのサンプリング周波数が
%   与えられた場合、SD 秒間継続するベクトル X を strips プロットします。
%
%   STRIPS(X,SD,Fs,SCALE) は、垂直軸をスケーリングします。
%
%   X が行列の場合、STRIPS(X,N), STRIPS(X,SD,Fs), STRIPS(X,SD,Fs,SCALE) は、
%   同じ strips プロット上に X のそれぞれの列をプロットします。
%
%   X が複素数の場合、strips は、その虚部を無視します。
%
%   参考 PLOT, STEM.


%   Copyright 1988-2007 The MathWorks, Inc.
