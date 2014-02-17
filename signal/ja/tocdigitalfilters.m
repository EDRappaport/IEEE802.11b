% 離散時間フィルタ設計、解析、実装 
% ---------------------------------------------------------
%
%   <a href="matlab:help dfilt">離散時間フィルタオブジェクト</a> - 離散時間浮動小数点-固定小数点フィルタ
%
% FIR フィルタ設計
%   <a href="matlab:help cfirpm">cfirpm</a>     - 複素数かつ非線形位相の等リップル FIR フィルタ設計
%   <a href="matlab:help fir1">fir1</a>       - ウィンドウベースの FIR フィルタの設計－low, high, band, stop, multi
%   <a href="matlab:help fir2">fir2</a>       - 周波数サンプリング法を使った FIR 任意整形フィルタ
%   <a href="matlab:help fircls">fircls</a>     - 制約条件付き最小二乗フィルタの設計 - 任意応答
%   <a href="matlab:help fircls1">fircls1</a>    - 制約条件付き最小二乗 FIR フィルタの設計 - ローパスとハイパス
%   <a href="matlab:help firls">firls</a>      - 最適化最小二乗線形位相 FIR フィルタの設計
%   <a href="matlab:help firpm">firpm</a>      - Parks-McClellan 最適等リップル FIR フィルタを設計
%   <a href="matlab:help firpmord">firpmord</a>   - Parks-McClellan 最適 FIR フィルタの次数推定
%   <a href="matlab:help intfilt">intfilt</a>    - インターポレーション FIR フィルタ設計
%   <a href="matlab:help kaiserord">kaiserord</a>  - フィルタ次数の推定ベースの Kaiser ウィンドウ設計
%   <a href="matlab:help sgolay">sgolay</a>     - Savitzky-Golay FIR 平滑化フィルタ設計
%
% 通信用フィルタ
%   <a href="matlab:help rcosdesign">rcosdesign</a>    - レイズドコサイン FIR フィルタの設計
%   <a href="matlab:help gaussdesign">gaussdesign</a>   - ガウス FIR パルス整形フィルタの設計
%
% IIR デジタルフィルタ設計
%   <a href="matlab:help butter">butter</a>    - バタワースフィルタ設計
%   <a href="matlab:help cheby1">cheby1</a>     - チェビシェフ I 型フィルタ設計 (通過帯域リップル)
%   <a href="matlab:help cheby2">cheby2</a>     - チェビシェフ II 型フィルタ設計 (遮断帯域リップル)
%   <a href="matlab:help ellip">ellip</a>     - 楕円フィルタ設計
%   <a href="matlab:help maxflat">maxflat</a>    - 一般化バタワースローパスフィルタ設計
%   <a href="matlab:help yulewalk">yulewalk</a>   - Yule-Walker フィルタ設計
%
% IIR フィルタの次数推定
%   <a href="matlab:help buttord">buttord</a>    - バタワースフィルタの次数推定
%   <a href="matlab:help cheb1ord">cheb1ord</a>   - チェビシェフ I 型フィルタの次数推定
%   <a href="matlab:help cheb2ord">cheb2ord</a>   - チェビシェフ II 型フィルタの次数推定
%   <a href="matlab:help ellipord">ellipord</a>   - 楕円フィルタの次数推定
%
% フィルタの解析
%   <a href="matlab:help abs">abs</a>       - 振幅
%   <a href="matlab:help angle">angle</a>     - 位相角
%   <a href="matlab:help filternorm">filternorm</a> - デジタルフィルタのノルムの計算
%   <a href="matlab:help freqz">freqz</a>      - Z-変換の周波数応答
%   <a href="matlab:help fvtool">fvtool</a>     - Filter Visualization ツール
%   <a href="matlab:help grpdelay">grpdelay</a>   - 群遅延
%   <a href="matlab:help impz">impz</a>       - 離散インパルス応答
%   <a href="matlab:help phasedelay">phasedelay</a> - デジタルフィルタの位相遅延
%   <a href="matlab:help phasez">phasez</a>     - デジタルフィルタの位相応答 (unwrapped)
%   <a href="matlab:help stepz">stepz</a>      - デジタルフィルタのステップ応答
%   <a href="matlab:help unwrap">unwrap</a>     - 位相角の連続性
%   <a href="matlab:help zerophase">zerophase</a>  - 実数フィルタのゼロ位相応答
%   <a href="matlab:help zplane">zplane</a>     - 離散極-零点プロット
%
% フィルタの実装
%   <a href="matlab:help conv">conv</a>       - コンボリューション
%   <a href="matlab:help conv2">conv2</a>      - 2 次元コンボリューション
%   <a href="matlab:help convmtx">convmtx</a>    - コンボリューション行列
%   <a href="matlab:help deconv">deconv</a>     - デコンボリューション
%   <a href="matlab:help fftfilt">fftfilt</a>    - Overlap-add フィルタの実行
%   <a href="matlab:help filter">filter</a>     - フィルタリング
%   <a href="matlab:help filter2">filter2</a>    - 2 次元デジタルフィルタリング 
%   <a href="matlab:help filtfilt">filtfilt</a>   - フィルタリングのゼロ位相バージョン
%   <a href="matlab:help filtic">filtic</a>     - フィルタの初期条件の定義
%   <a href="matlab:help latcfilt">latcfilt</a>   - ラティスフィルタの実行
%   <a href="matlab:help medfilt1">medfilt1</a>   - 1 次元メディアンフィルタリング
%   <a href="matlab:help sgolayfilt">sgolayfilt</a> - Savitzky-Golay フィルタの実行
%   <a href="matlab:help sosfilt">sosfilt</a>    - 2次型 (biquad) フィルタの実行
%   <a href="matlab:help upfirdn">upfirdn</a>    - アップサンプル、FIR フィルタ、ダウンサンプル
%
% <a href="matlab:help signal">Signal Processing Toolbox の目次</a>


%   Copyright 2005-2013 The MathWorks, Inc.
