%PSD  パワースペクトル密度 (PSD) の推定
%
%    Hpsd = PSD(H,X) は、H で指定した PSD 推定器を使って推定された、
%    離散時間信号ベクトル X の PSD 推定を含む DSP データオブジェクト 
%    (<a href="matlab:help dspdata">dspdata</a>) を返します。
%
%    有効な PSD 推定器:
%           <a href="matlab:help spectrum.periodogram">periodogram</a>    <a href="matlab:help spectrum.mcov">mcov</a>
%           <a href="matlab:help spectrum.welch">welch</a>          <a href="matlab:help spectrum.mtm">mtm</a>
%           <a href="matlab:help spectrum.burg">burg</a>           <a href="matlab:help spectrum.yulear">yulear</a>
%           <a href="matlab:help spectrum.cov">cov</a>
%
%    オブジェクト Hpsd に含まれる PSD データは、単位周波数に対するパワーの
%    分布です。実数信号に対して、PSD は、片側 PSD をデフォルトとして返します。
%    複素数信号の場合、両側 PSD を返します。片側 PSD は、入力信号のすべての
%    パワーを含んでいることに注意してください。
%
%    パワースペクトル密度は連続スペクトルに対する利用を意図しています。
%    平均二乗スペクトル (MSS) と異なり、この場合、スペクトル内のピークは、
%    与えられた周波数でのパワーを反映しないことに注意してください。代わりに、
%    任意の周波数帯での PSD の積分は、その周波数帯に対する信号の平均パワーを
%    計算します。詳細は、AVGPOWER のヘルプを参照してください。
%
%    Hpsd オブジェクトも、推定される PSD における正規化周波数ベクトル W を
%    含みます。W の単位は、ラジアン/サンプルです。実数信号に対して、W は、
%    NFFT が偶数の場合 [0,pi] の区間に広がり、NFFT が奇数の場合 [0,pi) の
%    範囲になります。複素数信号の場合、W は、常に、[0.2*pi) の区間です。
%
%    Hpsd = PSD(...,'Fs',Fs) は、物理的な周波数 (Hz) の関数として計算された
%    スペクトルを持つ PSD オブジェクトを返します。Fs は、Hz で指定された
%    サンプリング周波数です。
%
%    Hpsd = PSD(...,'SpectrumType','twosided') は、実数信号 X の両側 PSD を
%    持つ PSD オブジェクトを返します。この場合、スペクトルは、Fs が指定されて
%    いない場合 [0,2*Pi) の範囲、Fs が指定された場合 [0,Fs) の範囲で計算されます。
%    SpectrumType は、実数信号 X に対してデフォルトとなる 'onesided' も指定
%    できます。
%
%    Hpsd = PSD(...,'NFFT',nfft) は、パワースペクトル密度を計算するために
%    使われる FFT 点数として nfft を指定します。
%
%    Hpsd = PSD(...,'CenterDC',true) は、0 の周波数成分がスペクトルの中心と
%    なるようにシフトする必要のあるスペクトルを指定します。CenterDC は、
%    デフォルトで false に設定されます。
%
%    Hpsd = PSD(...,'FreqPoints','User Defined','FrequencyVector',f) は、
%    周波数のベクトル f で定義された周波数で評価される PSD オブジェクトを
%    返します。
%
%    Hpsd = PSD(...,'ConfLevel',p) は、信頼レベル p を指定します。p は、
%    区間 (0,1) 内の値を取ります。信頼区間は、2 列の行列として Hpsd 
%    オブジェクトに追加されます。1 番目の列は下限を含み、2 番目の列は
%    上限を含みます。
%
%    出力引数を設定しない PSD(...) は、デフォルトとして、現在の Figure 
%    ウィンドウに単位周波数に対する PSD を dB 単位でプロット表示します。
%
%    PSD に個々に入力引数を指定する代わりに、<a href="matlab:help 
%    spectrum/psdopts">psdopts</a> を使ってオプションのオブジェクトを
%    作成することができます。
%
%   例: 200Hz の余弦波と雑音を含む信号のスペクトル解析
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = cos(2*pi*t*200)+randn(size(t));
%      h = spectrum.welch;               % Welch スペクトル推定器の作成
%      psd(h,x,'Fs',Fs);                 % 片側 PSD の計算とプロット
%      hpsd = psd(h,x,'ConfLevel',p);    % 信頼レベルを持つ PSD
%      figure,plot(hpsd)
%
%    参考 SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
