%SOSFILT  2 次 (biquadratic) IIR フィルタを適用
%
%   SOSFILT(SOS, X) は、行列 SOSで記述された2 次型 (SOS) フィルタでベクトル 
%   X のデータをフィルタ処理します。SOS の係数行列は、L×6 の 2 次型行列を
%   使った式でなければなりません。ここで、L は 2 次型の数です。X が行列の場合、
%   SOSFILT は、X の各列にフィルタを適用します。X が多次元配列の場合、
%   フィルタは 1 番目の非シングルトン次元で処理を行ないます。
%
%   SOSFILT は、フィルタリングの時に直接 Ⅱ 型フィルタを使います。
%
%   行列 SOS は、以下の型でなければなりません。
%
%   SOS = [ b01 b11 b21 a01 a11 a21
%           b02 b12 b22 a02 a12 a22
%           ...
%           b0L b1L b2L a0L a1L a2L ]
%
%   SOSFILT(SOS, X, DIM) は、次元 DIM に沿って処理します。
%
%   参考 LATCFILT, FILTER, TF2SOS, SS2SOS, ZP2SOS, SOS2TF, SOS2SS, SOS2ZP.


%   Copyright 1988-2007 The MathWorks, Inc.
