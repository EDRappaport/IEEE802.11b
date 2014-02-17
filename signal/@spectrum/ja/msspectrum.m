%MSSPECTRUM  平均二乗スペクトル (MSS)
%
%    Hmss = MSSPECTRUM(H,X) は、H で指定した MSS 推定器を使って推定された、
%    離散時間信号ベクトル X の平均二乗 (パワー) 推定を含む DSP データオブジェクト 
%    (<a href="matlab:help dspdata">dspdata</a>) を Hmss に返します。
%
%    有効な MSS 推定器:
%           <a href="matlab:help spectrum.periodogram">periodogram</a>
%           <a href="matlab:help spectrum.welch">welch</a>
%
%    オブジェクト Hmss に含まれる平均二乗スペクトルは、周波数全体のパワーの
%    分布です。実数信号に対して、MSSPECTRUM は、デフォルトで片側平均二乗スペクトル
%    を返します。複素数信号に対して、両側平均二乗スペクトルを返します。片側平均
%    二乗スペクトルは、入力信号のすべてのパワーを含むことに注意してください。
%
%    平均二乗スペクトルは離散スペクトルを対象としています。パワースペクトル
%    密度 (PSD) とは異なり、平均二乗スペクトルのピークは任意周波数における
%    信号内のパワーを反映します。
%
%    Hmss オブジェクトは、平均二乗スペクトルを推定する点における正規化周波数
%    ベクトル W も含んでいます。W の単位は、ラジアン/サンプルです。実数信号に
%    対して、W は、NFFT が偶数の場合 [0,pi] の区間に広がり、NFFT が奇数の場合 
%    [0,pi) の範囲になります。複素数信号の場合、W は、常に、[0.2*pi) の区間です。
%
%    Hmss = MSSPECTRUM(H,X,'Fs',Fs) は、物理的な周波数 (Hz) の関数として計算
%    されるスペクトルを含む平均二乗スペクトルオブジェクトを返します。Fs は、
%    Hz で指定されたサンプリング周波数です。
%
%    Hmss = MSSPECTRUM(...,'SpectrumType','twosided') は、実数信号 X の両側
%    平均二乗スペクトルを持つ平均二乗スペクトルオブジェクトを返します。
%    この場合、スペクトルは、Fs が指定されていない場合 [0,2*Pi) の範囲、
%    Fs が指定された場合 [0,Fs) の範囲で計算されます。SpectrumType は、
%    実数信号 X に対してデフォルトとなる 'onesided' も指定できます。
%
%    Hmss = MSSPECTRUM(...,'NFFT',nfft) は、平均二乗スペクトルを計算する
%    ために使われる FFT 点数として nfft を指定します。
%
%    Hmss = MSSPECTRUM(...,'CenterDC',true) は、0 の周波数成分がスペクトルの
%    中心となるようにシフトする必要のあるスペクトルを指定します。CenterDC の
%    デフォルトは false が設定されています。
%
%    Hmss = MSSPECTRUM(...,'FreqPoints','User Defined','FrequencyVector',f)
%    は、周波数のベクトル f で定義された周波数で実行された平均二乗スペクトル
%    を返します。
%
%    Hmss = MSSPECTRUM(...,'ConfLevel',p) は、信頼レベル p を指定します。
%    p は、区間 (0,1) 内の値を取ります。信頼区間は、2 列の行列として Hmss 
%    オブジェクトに追加されます。1 番目の列は下限を含み、2 番目の列は上限を
%    含みます。
%
%    MSSPECTRUM(...) として出力引数を指定しない場合、デフォルトで現在の 
%    Figure ウィンドウに単位周波数について dB で平均二乗スペクトルを
%    プロットします。
%
%    MSSPECTRUM に個々に入力引数を指定する代わりに、<a href="matlab:help spectrum/msspectrumopts">msspectrumopts</a> を使ってオプションの
%    オブジェクトを作成することができます。
%
%   例 1:
%      % この例では、200Hz の周波数成分を持つ確定的なパワー信号のパワーを
%      % 測定します。3 ボルトのピークの振幅を持つ信号を使用するため、200Hz 
%      % での理論的なパワーは、3^2/2 ボルト^2 (ワット) または 6.5321dB で
%      % ある必要があります。
%      Fs = 1000;   t = 0:1/Fs:.2;
%      x = 3*cos(2*pi*t*200);
%      h = spectrum.welch;           % Welch スペクトル推定器の作成
%
%      % 片側平均二乗スペクトルのプロット
%      msspectrum(h,x,'Fs',Fs,'NFFT',2^14);
%
%   例 2:200 Hz 近辺の周波数で平均二乗スペクトルを評価します。
%      msspectrum(h,x,'Fs',Fs,'FreqPoints','User Defined','SpectrumType',...
%      'TwoSided','FrequencyVector',linspace(150,250,100),'ConfLevel',0.95);
%
%   参考 SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
