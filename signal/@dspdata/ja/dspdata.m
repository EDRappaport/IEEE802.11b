%DSPDATA  DSP データオブジェクト
%
%   Hs = DSPDATA.<DATAOBJECT>(...) は、DATAOBJECT で指定したタイプの DSP 
%   データオブジェクト Hs を返します。それぞれの DATAOBJECT は、いくつかの
%   入力を与えます。それぞれの DATAOBJECT は、複数の入力を受け入れます。
%
%   有効な DATAOBJECT のリストを以下に示します。(特定のデータオブジェクトの
%   ヘルプを取得するには、"help dspdata.<DATAOBJECT>" と入力してください。
%   - 例. "help dspdata.psd"):
%
%   <a href="matlab:help dspdata.msspectrum">msspectrum</a>     - 平均二乗スペクトル (MSS) データオブジェクト
%   <a href="matlab:help dspdata.psd">psd</a>            - パワースペクトル密度 (PSD) データオブジェクト
%   <a href="matlab:help dspdata.pseudospectrum">pseudospectrum</a> - 擬似スペクトルデータオブジェクト
%
%   以下のメソッドは、上述のオブジェクトに対して利用可能です (特定のメソッド
%   のヘルプを取得するには、"help dspdata/<METHOD>" と入力してください。
%   - 例. "help dspdata/avgpower")。
%
%   <a href="matlab:help dspdata/avgpower">avgpower</a>      - PSD データオブジェクトの平均パワー
%   <a href="matlab:help dspdata/centerdc">centerdc</a>      - 0 の周波数成分をスペクトルの中心にシフト
%   <a href="matlab:help dspdata/findpeaks">findpeaks</a>     - データオブジェクト内の局所的なピーク
%   <a href="matlab:help dspdata/halfrange">halfrange</a>     - 全体の半分のナイキスト区間で計算した擬似スペクトル
%   <a href="matlab:help dspdata/normalizefreq">normalizefreq</a> - 周波数の仕様を正規化
%   <a href="matlab:help dspdata/onesided">onesided</a>      - 全体の半分のナイキストの区間で計算された PSD または MSS (しかし、完全なパワーを含みます)
%   <a href="matlab:help dspdata/plot">plot</a>          - データオブジェクトに含まれるスペクトルのプロット
%   <a href="matlab:help dspdata/sfdr">sfdr</a>          - MSS データオブジェクトのスプリアスフリーダイナミックレンジ
%   <a href="matlab:help dspdata/twosided">twosided</a>      - ナイキスト区間全体で計算した PSD または MSS
%   <a href="matlab:help dspdata/wholerange">wholerange</a>    - ナイキスト区間全体で計算した擬似スペクトル
%
%   例: FFT を使って正弦波信号のパワーを計算し、PSD オブジェクトに結果を
%       格納してプロットします。
%
%        Fs = 32e3;   t = 0:1/Fs:2.96;
%        x  = cos(2*pi*t*10e3)+cos(2*pi*t*1.24e3)+ randn(size(t));
%        X  = fft(x);
%        P  = (abs(X).^2)/length(x)/Fs;  % PSD を形成するために、パワーを
%                                        % 計算し、スケーリングする
%
%        hpsd = dspdata.psd(P,'Fs',Fs,'SpectrumType','twosided');
%        plot(hpsd);                     % PSD のプロット
%
%
%   <a href="matlab:help signal">Signal Processing Toolbox の目次</a>
%
%   参考 SPECTRUM.


%   Copyright 1988-2008 The MathWorks, Inc.
