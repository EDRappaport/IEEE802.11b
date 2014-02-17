%MSSPECTRUM  平均二乗スペクトル
%
%   H = DSPDATA.MSSPECTRUM(DATA) は、データプロパティの設定で DATA に
%   指定された平均二乗スペクトルのオブジェクト H のインスタンスを作成します。
%   DATA はパワーを表すため、実数で正の値を含んでいなければなりません。
%   DATA は、ベクトルまたは行列になります。ここで、各列は、独立試行を表します。
%   対応する周波数ベクトルは、[0, pi] の範囲内で自動的に生成されます。
%   Fs は、デフォルトで "Normalized" です。
%
%   平均二乗スペクトルは離散スペクトルを対象としています。パワースペクトル
%   密度 (PSD) とは異なり、平均二乗スペクトルのピークは任意周波数における
%   信号内のパワーを反映します。
%
%   H = DSPDATA.MSSPECTRUM(DATA,FREQUENCIES) は、H に返されるデータオブジェクト
%   に周波数ベクトル FREQUENCIES を設定します。ベクトル FREQUENCIES の長さは、
%   DATA の列の長さと等しくなければなりません。
%
%   H = DSPDATA.MSSPECTRUM(...,'Fs',Fs) は、サンプリング周波数を Fs に設定
%   します。FREQUENCIES が指定されない場合、周波数ベクトルは、デフォルトで 
%   [0,Fs/2] です。詳細は、以下の注意を参照してください。
%
%   H = DSPDATA.MSSPECTRUM(...,'SpectrumType',SPECTRUMTYPE) は、SpectrumType 
%   プロパティを SPECTRUMTYPE で指定される文字列 'onesided' または 'twosided' の
%   いずれかに設定します。
%
%   H = DSPDATA.MSSPECTRUM(...,'CenterDC',true) は、データの DC 値をベクトル
%   の中央にすることを示します。CenterDC を true に設定すると、自動的に 
%   'SpectrumType' が 'twosided' に設定されます。
%
%   周波数ベクトルが指定されない場合、デフォルトの周波数ベクトルは、
%   'CenterDC' の設定に従って生成されます。周波数ベクトルが指定された場合、
%   'CenterDC' は、指定した周波数ベクトル (とデータ) と一致するように設定
%   する必要があります。このプロパティを修正するには、<a href="matlab:help dspdata/centerdc">centerdc</a> メソッドを
%   使用してください。
%
%   注意： 指定したスペクトルデータが "半分の" ナイキスト区間で計算され、
%   対応する周波数ベクトルを指定していない場合、デフォルトの周波数ベクトルは、
%   "全体の" FFT 内の点数が偶数であるものと仮定します。さらに、"全体の" 
%   スペクトルに変換するためのプロットオプションは、オリジナルの "全体の" 
%   FFT 長が偶数であるものと仮定します。
%
%   例: 2 つの周波数成分を持つノイズを含む正弦波信号の平均二乗スペクトルを
%            計算するために FFT を使用します。MSSPECTRUM データオブジェクトに
%            結果を格納し、プロットします。
%
%        Fs = 32e3;   t = 0:1/Fs:2.96;
%        x = cos(2*pi*t*1.24e3) + cos(2*pi*t*10e3) + randn(size(t));
%        X = fft(x);
%        P = (abs(X)/length(x)).^2;    % 平均二乗を計算
%
%        hms = dspdata.msspectrum(P,'Fs',Fs,'SpectrumType','twosided');
%        plot(hms);                         % 平均二乗スペクトルをプロット
%
%   参考 DSPDATA, SPECTRUM.


%   Copyright 1988-2008 The MathWorks, Inc.
