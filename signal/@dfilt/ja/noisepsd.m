%NOISEPSD  丸め雑音によるフィルタの出力のパワースペクトル密度
%
%   Hpsd = NOISEPSD(Hd,L) は、フィルタの量子化誤差により生成される丸め
%   雑音によるフィルタ Hd の出力でパワースペクトル密度 (PSD) を計算します。
%   L は使われる試行回数です。PSD は、L の試行全体の平均から計算されます。
%   試行回数が多いほど (長い計算を犠牲にして) よい推定になります。L が
%   設定されていない場合、デフォルトで 10 回の試行になります。
%
%   Hpsd は PSD データオブジェクトです。PSD ベクトルは、GET(Hpsd,'Data') で 
%   Hpsd から抽出することができます。PLOT(Hpsd) を使ってプロットすることが
%   できます。出力ノイズの平均パワー (PSD の積分) は、AVGPOWER(Hpsd) で
%   計算することができます。
%
%   Hpsd = NOISEPSD(Hd,L,P1,V1,P2,V2,...) は、パラメータ-値の組み合わせで
%   オプションパラメータを指定します。有効な組み合わせはつぎの通りです:
%        パラメータ               デフォルト     説明/有効な値
%   ---------------------  -----------  ----------------------------------
%   'NFFT'                 512          FFT 点数
%   'NormalizedFrequency'  true         {true,false}
%   'Fs'                   'Normalized' サンプリング周波数'NormalizedFrequency' 
%                                       が false のときのみ使用
%   'SpectrumType'         'Onesided'   {'Onesided','Twosided'}
%   'CenterDC'             false        {true,false}
%
%   NOISEPSD(Hd,L,OPTS) は、指定するパラメータ-値の組み合わせの lieu 内の
%   オプションのパラメータを指定するために、オプションのオブジェクトを
%   使用します。OPTS オブジェクトは、OPTS = NOISEPSDOPTS(Hd) で作成できます。
%   設定は、NOISEPSD を呼び出す前に OPTS で変更できます。
%   たとえば、set(OPTS,'Fs',48e3);
%
%   % 例:直接型で実装された固定小数点 FIR フィルタの量子化によるに出力の
%   % ノイズの PSD を計算します。
%   f = fdesign.lowpass('N,Fp,Fst',27,.4,.6);
%   h = design(f,'equiripple','FilterStructure','dffir');
%   h.Arithmetic = 'fixed';
%   specifyall(h); h.OutputFracLength=15;
%   Hpsd = noisepsd(h);
%   plot(Hpsd)
%
%   参考 DFILT/NOISEPSDOPTS, DFILT/FREQRESPEST, DFILT/SCALE, 
%        DFILT/FUNCTIONS, DSPDATA/PSD.


%   Copyright 1988-2007 The MathWorks, Inc.
