%TRIPULS  サンプリングされた非周期的な三角波を作成
%
%   TRIPULS(T) は、連続で非周期的な高さが 1 の三角パルスを T = 0 を中心に、
%   配列 T で示される時刻に作成します。デフォルトでは、三角形は対称で、
%   幅が 1 です。
%
%   TRIPULS(T,W) は、幅 W の三角パルスです。
%
%   TRIPULS(T,W,S) は、歪み S をもつ三角パルスを作成します。S は -1 から 
%   1 の間の数です。S が 0 の場合、対称な三角パルスが作成されます。
%
%   参考 SQUARE, SIN, COS, CHIRP, DIRIC, GAUSPULS, PULSTRAN, RECTPULS.


%   Copyright 1988-2007 The MathWorks, Inc.
