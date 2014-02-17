%FREQZ  デジタルフィルタ周波数応答
%
%   [H,W] = FREQZ(B,A,N) は、N 点でのフィルタの複素周波数応答ベクトル 
%   H とそれを計算する N 点の周波数ベクトル (単位はラジアン/サンプル) を
%   返します。
%               jw               -jw              -jmw
%        jw  B(e)    b(1) + b(2)e + .... + b(m+1)e
%     H(e) = ---- = ------------------------------------
%               jw               -jw              -jnw
%            A(e)    a(1) + a(2)e + .... + a(n+1)e
%   は、ベクトル B と A に、分子と分母の係数を設定します。周波数応答は、
%   単位円の上半分の等間隔な N 点を評価します。N を指定しない場合、
%   デフォルトは 512 です。
%
%   [H,W] = FREQZ(B,A,N,'whole') は、単位円全体の N 点を使います。
%
%   H = FREQZ(B,A,W) は、設定する周波数をラジアン/サンプル単位で、
%   ベクトル W に設定 (通常は、0 からπ) した周波数に対する応答を返します。
%
%   [H,F] = FREQZ(B,A,N,Fs) と [H,F] = FREQZ(B,A,N,'whole',Fs) は、周波数
%   ベクトル F (Hz 単位) も返します。ここで、Fs はサンプリング周波数 (Hz 単位) です。
%
%   H = FREQZ(B,A,F,Fs) は、ベクトル F (Hz 単位) に設定した周波数で、
%   複素周波数応答を返します。ここで、Fs はサンプリング周波数 (Hz 単位) です。
%
%   FREQZ(B,A,...) 自身では、現在の Figure ウィンドウ内にゲインと連続に
%   補正された位相をプロットします。
%
%   参考 FILTER, FFT, INVFREQZ, FVTOOL, FREQS.


%   Copyright 1988-2007 The MathWorks, Inc.
