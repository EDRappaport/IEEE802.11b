%PERIODOGRAM  ピリオドグラムスペクトル推定器
%
%   H = SPECTRUM.PERIODOGRAM は、H にピリオドグラムスペクトル推定器を返します。
%
%   H = SPECTRUM.PERIODOGRAM(WINNAME) は、ウィンドウとして WINNAME で指定
%   された文字列を持つピリオドグラムスペクトル推定器 H を返します。有効な 
%   <a href="matlab:set(spectrum.periodogram,'WindowName')">ウィンドウ</a> のリストを取得するには、set(H,'WindowName') を使用してください。
%
%   H = SPECTRUM.PERIODOGRAM({WINNAME,WINPARAMETER}) は、セル配列内の 
%   WINNAME にウィンドウを、WINPARAMETER にウィンドウのパラメータ値を
%   指定します。
%
%   注意：WINNAME で指定されたウィンドウに依存して、ウィンドウパラメータの
%   プロパティは、ピリオドグラムスペクトル推定器 H に動的に追加されます。
%   詳細は、"help <WINNAME>" と入力してください。
%
%   デフォルトウィンドウ (箱型) は、13.3 dB のサイドローブの減衰を持つことに
%   注意してください。これは、(ピークのスペクトルに対する) この値のもとで
%   スペクトルにマスクをかける可能性があります。別のウィンドウを選択すると、
%   分解能 (例. 箱型ウィンドウを使用) とサイドローブの減衰 (例. Hann ウィンドウを
%   使用) 間のトレードオフを行うことが可能になります。詳細は、WinTool を
%   参照してください。
%
%   ピリオドグラムの PSD 推定器は、そのような関数を実行するためにデータと
%   共に下記の関数に渡すことができます。
%       <a href="matlab:help spectrum/msspectrum">msspectrum</a>     - 平均二乗スペクトル (MSS) を計算
%       <a href="matlab:help spectrum/msspectrumopts">msspectrumopts</a> - MSS を計算するためのオプションを出力
%       <a href="matlab:help spectrum/psd">psd</a>     - PSD を計算
%       <a href="matlab:help spectrum/psdopts">psdopts</a> - PSD を計算するためのオプションを出力
%
%   例: 複素信号に雑音を加えた信号のスペクトル解析
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = exp(i*2*pi*200*t)+randn(size(t));
%      h = spectrum.periodogram;      % ピリオドグラムスペクトル推定器の作成
%      psd(h,x,'Fs',Fs);                    % 両側 PSD の計算とプロット
%
%   参考 SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
