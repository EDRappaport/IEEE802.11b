% FIRGAUSS FIR Gaussian デジタルフィルタ設計
%
% B = FIRGAUSS(K,N) は、FIR フィルタの設計をします。
% このインパルス応答は、理想的なガウス分布を近似します。 このフィルタは
% 長さ N のcascading K uniform-coefficient (boxcar) フィルタにより実現
% されます。フィルタ全体のインパルス応答の長さは、K*(N-1)+1です。
% フィルタの係数は、ベクトルBに出力されます。
%
% [B, N] = FIRGAUSS(K,'minorder',V) は、分散Vをもつガウスフィルタを設計
% します。標準偏差の二乗として定義される、この分散は、個々のboxcarフィルタ
% のコンボリューション(カスケード)の分散の和です。K >= 4の場合、FIRGAUSSは、
% 各boxcar フィルタの長さN を決定するために、最適なテクニックを使用します。
% この最適なテクニックは、フィルタのインパルス応答と、理想的なガウス分布
% との間の二乗平均平方根(rms)の差を最小にするガウス近似になります。
%
% 例題:
%  % 長さ32の4 boxcar フィルタのカスケード  
%     K = 4; N = 32;    
%     b = firgauss(K,N); 
%     fvtool(b,'impulse');
%
% 参考 GAUSSWIN, GAUSPULS, GMONOPULS.


%   Copyright 1988-2004 The MathWorks, Inc.
