%STEPZ  デジタルフィルタのステップ応答
%
%   [S,T] = STEPZ(B,A) は、フィルタ B/A のステップ応答を計算して、サンプル数を
%   選択し、ベクトル S に返します。評価された S での時間サンプルのベクトルは、
%   ベクトル T に返されます。
%
%   [H,T] = STEPZ(B,A,N) は、ステップ応答の最初の N サンプルを計算します。
%
%   [H,T] = STEPZ(B,A,N,Fs) は、T = 1/Fs で時間サンプルを分離します。Fs は、
%   Hz であると仮定します。
%
%   STEPZ(...) として出力引数をもたない場合、ステップ応答をプロットします。
%
%   % 例: 3 次のバタワースデジタルフィルタのステップ応答。
%   [b,a] = butter(3,.4);
%   stepz(b,a)
%
%   参考 IMPZ, FREQZ, ZPLANE, GRPDELAY, FVTOOL.


%   Copyright 1988-2007 The MathWorks, Inc.
