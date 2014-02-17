%WELCH  Welch 法スペクトル推定器
%
%   H = SPECTRUM.WELCH は、H に Welch 法スペクトル推定器を返します。
%
%   H = SPECTRUM.WELCH(WINNAME) は、ウィンドウとして WINNAME で指定された
%   文字列を持つ Welch 法スペクトル推定器 H を返します。
%   有効な <a href="matlab:set(spectrum.welch,'WindowName')">ウィンドウ</a> のリストを取得するには、
%   set(H,'WindowName') を使用してください。
%
%   H = SPECTRUM.WELCH({WINNAME,WINPARAMETER}) は、セル配列内の WINNAME に
%   ウィンドウを、WINPARAMETER にウィンドウのパラメータ値を指定します。
%
%   注意：WINNAME で指定されたウィンドウに依存して、ウィンドウパラメータの
%   プロパティは、Welch 法スペクトル推定器 H に動的に追加されます。詳細は、
%   "help <WINNAME>" と入力してください。
%
%   さらに、デフォルトウィンドウ (Hamming) は、42.5 dB のサイドローブの減衰を
%   持つことにも注意してください。これは、(ピークのスペクトルに対する) 
%   この値のもとでスペクトルにマスクをかける可能性があります。別のウィンドウを
%   選択すると、分解能 (例. 箱型ウィンドウを使用) とサイドローブの減衰 
%   (例. Hann ウィンドウを使用) 間のトレードオフを行うことが可能になります。
%   詳細は、WinTool を参照してください。
%
%   H = SPECTRUM.WELCH(WINNAME,SEGMENTLENGTH) は、SEGMENTLENGTH として
%   各セグメントの長さを指定します。セグメントの長さは、分解能と分散の
%   トレードオフになります。長いセグメント長は、良い分解能になる一方で、
%   短いセグメント長は、多くの平均を行います。そのため、分散が減少します。
%
%   H = SPECTRUM.WELCH(WINNAME,SEGMENTLENGTH,OVERLAPPERCENT) は、
%   各セグメント間のオーバーラップの割合を指定します。
%
%   Welch 法の PSD 推定器は、そのような関数を実行するためにデータと共に
%   下記の関数に渡すことができます。
%       <a href="matlab:help spectrum/msspectrum">msspectrum</a>     - 平均二乗スペクトル (MSS) を計算
%       <a href="matlab:help spectrum/msspectrumopts">msspectrumopts</a> - MSS を計算するためのオプションを出力
%       <a href="matlab:help spectrum/psd">psd</a>     - PSD を計算
%       <a href="matlab:help spectrum/psdopts">psdopts</a> - PSD を計算するためのオプションを出力
%
%   例: 200Hz の余弦波とノイズを含む信号のスペクトル解析
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = cos(2*pi*t*200)+randn(size(t));
%      h = spectrum.welch;           % Welch スペクトル推定器の作成
%      psd(h,x,'Fs',Fs);              % PSD の計算とプロット
%
%   参考 SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
