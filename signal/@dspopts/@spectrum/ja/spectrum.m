% SPECTRUM   スペクトル解析のためのオブジェクトのオプション
%
% OPTS = DSPOPTS.SPECTRUM は、メソッドに対して追加の入力引数を指定する
% ためのあるスペクトル解析方法に対する入力引数として使用することのできる
% オブジェクトです。
%
% OPTS は、つぎの追加の引数が含まれます:
%
%   パラメータ             デフォルト   詳細/有効な値
%   ----------             ---------    -------------
%   'NFFT'                 8192         FFT点数
%   'NormalizedFrequency'  true         {true,false}
%   'Fs'                   'Normalized' サンプリング周波数。'NormalizedFrequency' が
%                                       false のときのみ使用できます。
%   'SpectrumType'         'Onesided'   {'Onesided','Twosided'}
%
% 通常は、OPTS を直接作成しないことに注意してください。代りに、OPTS は、
% 他のメソッドから得ることができます。いくつかのばあいに、OPTS を作成する
% ためにメソッドを使う場合、デフォルト値は、上述のこれらのリストとは
% 異なります。
%
% 例題: SPECTRUM.WELCHオブジェクトに対する DSPOPTS.SPECTRUM オブジェクトを作成します。
%   s = spectrum.welch; 
%   n = 0:199;  
%   Fs = 48e3;
%   x = sin(2*pi*n*10e3/Fs)+2*sin(2*pi*n*20e3/Fs)+randn(1,200);
%   opts = psdopts(s,x);
%   opts.Fs = Fs;  % opts.NormalizedFrequencyをfalseに設定
%   d = psd(s,x,opts);
%
%   参考 SPECTRUM/SPECTRUMOPTS, SPECTRUM/PSD, SPECTRUM/MSSPECTRUM.


%   Author(s): R. Losada
%   Copyright 1988-2004 The MathWorks, Inc.
