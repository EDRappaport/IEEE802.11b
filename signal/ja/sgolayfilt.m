%SGOLAYFILT  Savitzky-Golay フィルタを適用
%
%   SGOLAYFILT(X,K,F) は、信号 X に Savitzky-Golay (多項式) 平滑化フィルタを
%   適用してフィルタリングします。多項式の次数 K は、フレームサイズ F より
%   短くなければなりません。そして、F は奇数でなければなりません。また、
%   入力 X の長さは、F 以上でなければなりません。X が行列の場合、SGOLAYFILTS は、
%   各列に機能します。
%
%   多項式の次数 K = F-1 の場合、フィルタは平滑化を行いません。
%
%   SGOLAYFILT(X,K,F,W) は、長さ F の重みベクトル W を設定します。これは、
%   最小二乗による処理過程の間に使われる正の実数値の重みを含んだものです。
%   指定されなかったり、空として指定された場合、W は、デフォルトで単位行列です。
%
%   SGOLAYFILT(X,K,F,[],DIM)、あるいは、SGOLAYFILT(X,K,F,W,DIM) は、次元 
%   DIM に沿って処理します。
%
%   参考 SGOLAY, MEDFILT1, FILTER


%   Copyright 1988-2007 The MathWorks, Inc.
