%SAWTOOTH  ノコギリ波または三角波を発生
%
%   SAWTOOTH(T) は、時間ベクトル T の要素に対して周期 2πをもつノコギリ波を
%   生成します。SAWTOOTH(T) は、SIN(T) と似ていますが、正弦波ではなく、-1 と 
%   1 にピークをもつノコギリ波を作成します。
%
%   SAWTOOTH(T,WIDTH) は、変形三角波を生成します。ここで、WIDTH は、0 と 
%   1 の間のスカラのパラメータであり、最大となる位置を 0 と 2πの間で決定
%   します。この関数は、0 から WIDTH*2*pi の区間では -1 から 1 に増加し、
%   WIDTH*2*pi から 2*pi の区間では、1 から -1 に線形的に減少します。従って、
%   WIDTH =0.5 は、ピーク値が 1 で、ピーク間隔が対称な標準三角形を示します。
%   SAWTOOTH(T,1) は、SAWTOOTH(T) と等価です。
%
%   警告:この関数は入力を大きな数にすると不正確になります。
%
%   参考 SQUARE, SIN, COS, CHIRP, DIRIC, GAUSPULS, PULSTRAN, RECTPULS, SINC, 
%        TRIPULS.


%   Copyright 1988-2007 The MathWorks, Inc.
