%NORMALIZEFREQ  周波数仕様の正規化
%
%   NORMALIZEFREQ(H) は、DSP データオブジェクト (<a href="matlab:help dspdata">dspdata</a>) 
%   H の周波数の仕様を正規化します。これは、データオブジェクト 
%   'NormalizedFrequency' プロパティを true に設定し、0 と 1 の範囲になるよう 
%   Fs で Frequencies を正規化します。
%
%   NORMALIZEFREQ(H,BFL) は、'NormalizedFrequency' プロパティを true または 
%   false のいずれかになる boolean フラグ BFL の値に設定します。指定されない
%   場合、BFL はデフォルトで true です。BFL が false の場合、データオブジェクト 
%   H の周波数は、線形周波数に変換されます。
%
%   NORMALIZEFREQ(H,false,Fs) は、'NormalizedFrequency' プロパティが false に
%   設定される場合、新規のサンプリング周波数 Fs の設定を受け入れます。
%
%   例: ノイズを含む正弦波のパワースペクトル密度を推定するために periodogram を
%       使用します。PSD データオブジェクトに結果を格納し、正規化周波数に変換して、
%       プロットします。
%
%         Fs = 32e3;   t = 0:1/Fs:2.96;
%         x = cos(2*pi*t*1.24e3)+ cos(2*pi*t*10e3)+ randn(size(t));
%         Pxx = periodogram(x);
%         hpsd = dspdata.psd(Pxx,'Fs',Fs) % PSD データオブジェクトの作成
%         normalizefreq(hpsd);            % 周波数の正規化
%         plot(hpsd)
%
%   参考 DSPDATA, SPECTRUM.


%   Copyright 1988-2007 The MathWorks, Inc.
