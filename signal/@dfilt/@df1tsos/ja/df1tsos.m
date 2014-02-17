% DF1TSOS   直接型I転置構成、2次型
%
% Hd = DFILT.DF1TSOS(S) は、S 行列で与えられた係数をもつ、離散時間で
% 2次型、直接型Iの転置構成のフィルタオブジェクト Hd を出力します。
% 
% Hd = DFILT.DF1TSOS(b1,a1,b2,a2,...) は、1番目のセクションが b1 と a1 
% のベクトルで与えられ、2番目のセクションが b2 と a2 のベクトルで与え
% られるようなけ係数をもつ、離散時間で、2次型、直接型Iの転置構成の
% フィルタオブジェクト Hd を出力します。
% 
% Hd = DFILT.DF1TSOS(...,g) は、ゲインベクトル g を含みます。g の要素は
% 各セクションのゲインです。g の最大長はセクション数＋1です。g が指定
% されない場合、すべてのゲインはデフォルトで1です。
%
% % 例題: 6次のローパス楕円フィルタの設計による係数をもつ、直接型Iの
% %       転置構成、2次型の離散時間フィルタ
%   [z,p,k] = ellip(6,1,60,.4);                                                  
%   [s,g] = zp2sos(z,p,k);                                                     
%   Hd = dfilt.df1tsos(s,g)  
%
% 参考 DFILT/DF1T, DFILT/DF1, DFILT/DF1SOS, DFILT/DF2
%        DFILT/DF2SOS, DFILT/DF2T, DFILT/DF2TSOS.
  

%   Author: Thomas A. Bryan
%   Copyright 1988-2004 The MathWorks, Inc.
