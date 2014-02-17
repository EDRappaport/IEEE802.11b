%TF2LATC  伝達関数をラティスフィルタに変換
%
%   K = TF2LATC(NUM) は、NUM(1) で正規化された FIR(MA) ラティスフィルタに
%   対するラティスパラメータ K を求めます。FIR フィルタの零点が単位円上に
%   ある場合には、誤差が生じる場合があります。
%
%   K = TF2LATC(NUM,'max') で、NUM は最大位相 FIR フィルタに対応し、FIR 
%   ラティスに変換する前に NUM を反転させ、共役化します。これは、abs(K) <= 1 
%   となり、LATCFILT の 2 番目の出力として最大位相フィルタを実現するために
%   用いられます。
%
%   K = TF2LATC(NUM,'min') で、NUM は最小位相 FIR フィルタに対応し、これは、
%   abs(K) <= 1 となり、LATCFILT の 1 番目の出力として最小位相フィルタを
%   実現するために用いられます。
%
%   K = TF2LATC(NUM,DEN,...) で、DEN は、K = TF2LATC(NUM/DEN,...) と等価な
%   スカラです。
%
%   [K,V] = TF2LATC(NUM,DEN) は、DEN(1) で正規化された IIR (ARMA) ラティス-ラダー
%   フィルタに対するラティスパラメータ K とラダーパラメータ V を求めます。
%   伝達関数の極が単位円上にある場合には、誤差が生じる場合があります。
%
%   K = TF2LATC(1,DEN) は、IIR 全極 (AR) ラティスフィルタに対するラティス
%   パラメータ K を求めます。[K,V] = TF2LATC(B0,DEN) は、B0 がスカラの場合、
%   ラダー係数 V のベクトルを返します。この場合、V の最初の要素のみが非零で
%   あることに注意してください。
%
%   例:
%   % 全極 IIR フィルタをラティス係数に変換:
%      DEN = [1 13/24 5/8 1/3];
%      K = tf2latc(1,DEN);  % K は [1/4 1/2 1/3]' になります
%
%   参考 LATC2TF, LATCFILT, POLY2RC and RC2POLY.


%   Copyright 1988-2007 The MathWorks, Inc.
