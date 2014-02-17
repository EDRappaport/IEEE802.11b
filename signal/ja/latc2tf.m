%LATC2TF  ラティスフィルタを伝達関数に変換
%
%   [NUM,DEN] = LATC2TF(K,V) は、ラティス係数 K とラダー係数 V をもつ 
%   IIR フィルタから分子 NUM、分母 DEN をもつ伝達関数を求めます。
%
%   [NUM,DEN] = LATC2TF(K,'allpole') では、K は全極 IIR ラティスフィルタに
%   対応するものと仮定します。
%
%   [NUM,DEN] = LATC2TF(K,'allpass') では、K はオールパスの IIR ラティス
%   フィルタに対応するものと仮定します。
%
%   NUM = LATC2TF(K) と NUM = LATC2TF(K,'fir') は、K が FIR フィルタ構造に
%   対応し、構造体の出力の上側が利用されるものと仮定します (FIR の場合に 
%   LATCFILT の 1 番目の出力に対応)。
%
%   NUM = LATC2TF(K,'min') は、abs(K) <= 1 のとき、K が最小位相 FIR ラティス
%   フィルタ構造に対応するものと仮定します。
%
%   NUM = LATC2TF(K,'max') は、abs(K) <= 1 として、K が最大位相 FIR ラティス
%   フィルタ構造に対応し、構造の出力の下側が利用されるものと仮定します 
%   (FIR の場合に LATCFILT の 2 番目の出力に対応)。
%
%   参考 LATCFILT AND TF2LATC.


%   Copyright 1988-2007 The MathWorks, Inc.
