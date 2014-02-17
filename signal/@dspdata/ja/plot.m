%PLOT  DSP データ (DSPDATA) オブジェクトのプロット
%
%   PLOT(H) は、<a href="matlab:help dspdata">dspdata</a> オブジェクト H の
%   データをプロットします。
%
%   例: 2 つの周波数成分をもつノイズを含む正弦波のパワースペクトル密度を
%       推定するために periodogram を使用します。オブジェクトに結果を格納し、
%       プロットします。
%
%        Fs = 32e3;   t = 0:1/Fs:2.96;
%        x = cos(2*pi*t*1.24e3)+ cos(2*pi*t*10e3)+ randn(size(t));
%        Pxx = periodogram(x);
%        hpsd = dspdata.psd(Pxx,'Fs',Fs); % PSD データオブジェクトの作成
%        plot(hpsd);                     % PSD のプロット
%
%   参考 DSPDATA, SPECTRUM.


%   Copyright 1988-2007 The MathWorks, Inc.
