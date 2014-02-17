%MTM  Thomson マルチテーパ法 (MTM) のパワースペクトル密度 (PSD) 推定器
%
%   H = SPECTRUM.MTM(TIMEBW) は、時間-帯域幅の積が TIMEBW に設定された 
%   MTM の PSD 推定器を返します。時間 - 帯域幅の積は、データウィンドウ
%   として使用される離散扁長回転楕円体列 (または Slepian 列) です。
%
%   H = SPECTRUM.MTM(DPSS,CONCENTRATIONS) は、離散扁長回転楕円体例とそれらの
%   集中度がそれぞれ DPSS と CONCENTRATIONS に設定された mtm スペクトル推定器を
%   返します。これらの 2 つの入力引数の詳細については、"help dpss" と入力して
%   ください。
%
%   注意：DPSS と CONCENTRATIONS を指定すると、MTM 推定器を作成するときに、
%   SpecifyDataWindowAs プロパティの値をデフォルト値 'TimeBW' から 'DPSS' に
%   自動的に変更します。
%
%   H = SPECTRUM.MTM(...,COMBINEMETHOD) は、個々のスペクトル推定器を結合する
%   ためのアルゴリズムを指定します。COMBINEMETHOD は、以下の文字列の 1 つを
%   使用できます。
%      'Adaptive'   - Thomson の適応非線形結合
%      'Eigenvalue' - 固有値を重みとする線形結合
%      'Unity'      - 単位重みを使った線形結合
%
%   MTM の PSD 推定器は、そのような関数を実行するためにデータと共に下記の
%   関数に渡すことができます。
%       <a href="matlab:help spectrum/psd">psd</a>     - PSD を計算
%       <a href="matlab:help spectrum/psdopts">psdopts</a> - PSD を計算するためのオプションを出力
%
%   例 #1: 200Hz の正弦波に雑音を加えます。
%      Fs = 1000;   t = 0:1/Fs:.3;
%      x = cos(2*pi*t*200)+randn(size(t));
%      h = spectrum.mtm(3.5);         % MTM スペクトル推定器を作成する場合、
%                                     % 時間-帯域幅の積を指定
%      psd(h,x,'Fs',Fs);              % PSD の計算とプロット
%
%   例 #2: 上記と同じ例ですが、時間 BW の積の代わりに、データテーパとその集中
%   度を指定します。
%      Fs = 1000;   t = 0:1/Fs:.3;
%      x = cos(2*pi*t*200)+randn(size(t));
%      [E,V] = dpss(length(x),3.5);
%      h = spectrum.mtm(E,V);          % MTM スペクトル推定器を作成する場合、
%                                      % DPSS と集中度を指定
%      psd(h,x,'Fs',Fs);              % PSD の計算とプロット
%
%   参考 SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
