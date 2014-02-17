% DF1T  直接型I転置構成
%
% Hd = DFILT.DF1T(NUM, DEN) は、離散時間直接型Iの転置構成のフィルタ
% オブジェクトを作成します。
%
%   % 例題
%   [b,a] = butter(4,.5);
%   Hd = dfilt.df1t(b,a)
%
% 参考 DFILT/DF1TSOS, DFILT/DF1, DFILT/DF1SOS, DFILT/DF2
%        DFILT/DF2SOS, DFILT/DF2T, DFILT/DF2TSOS.
  

%   Author: P. Costa
%   Copyright 1988-2004 The MathWorks, Inc.
