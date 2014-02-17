%GRPDELAY  デジタルフィルタの群遅延
%
%   [Gd,W] = GRPDELAY(B,A,N) は、N 個の計算した点における周波数 W (ラジアン
%   単位) と群遅延 Gd を含む長さ N のベクトルを返します。群遅延は、
%   -d{angle(w)}/dw で表せます。周波数応答は、単位円の上半分の等間隔な 
%   N 点を評価します。N が 2 のベキ乗の場合の FIR フィルタに対して、計算は 
%   FFT アルゴリズムを使用して高速に行われます。N を指定しない場合、
%   デフォルトは 512 です。
%
%   GRPDELAY(B,A,N,'whole') は、単位円全体の円周上の N 点を使用します。
%
%   [Gd,F] = GRPDELAY(B,A,N,Fs)、または [Gd,F] = GRPDELAY(B,A,N,'whole',Fs) は、
%   サンプリング周波数 Fs を Hz 単位で設定すると、ベクトル F に周波数を返します。
%
%   Gd = GRPDELAY(B,A,W)、または、Gd = GRPDELAY(B,A,F,Fs) は、それぞれ W 
%   (ラジアン/サンプル単位)、または F (Hz 単位) の点で計算した群遅延を返します。
%
%   出力引数をもたない GRPDELAY(B,A,...) は、正規化された周波数 (ナイキスト
%   周波数が 1) に対する群遅延を現在の Figure ウィンドウにプロットします。
%
%   参考 FREQZ


%   Copyright 1988-2007 The MathWorks, Inc.
