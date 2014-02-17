%PSEUDOSPECTRUMOPTS  擬似スペクトルオプションのオブジェクト
%
%   Hopts = PSEUDOSPECTRUMOPTS(Hs) は、Hs に指定された擬似スペクト推定器に
%   対して Hopts に擬似スペクトルオプションのオブジェクトを返します。
%
%   有効な擬似スペクトル推定器:
%           <a href="matlab:help spectrum.eigenvector">eigenvector</a>
%           <a href="matlab:help spectrum.music">music</a>
%
%   Hopts は、次のプロパティを含みます:
%
%   プロパティ            有効な値と説明
%   ---------           ----------------------------
%   FreqPoints          [ {All} | ユーザ定義 ]
%                       Full は、すべてのナイキスト範囲を示し、動的に 
%                       NFFT プロパティを作成します。ユーザ定義は、動的に 
%                       FrequencyVector プロパティを作成し、ユーザがその点で
%                       擬似スペクトルを評価するための周波数を指定することを
%                       許可します。
%
%   NFFT                [ Auto | {Nextpow2} または正の整数]
%                       FFT 点数。Auto は、最大の 256、または入力 (または 
%                       Welch のセグメント) の長さを使用します。
%                       Nextpow2 は Auto と同じですが、次の 2 のべき乗を
%                       使用します。
%
%   FrequencyVector     [ Fs より小さい実数の数値で double のベクトル ]
%                       擬似スペクトルを評価するための点における周波数
%                       ベクトルを指定します。
%
%   NormalizedFrequency [ {true} | false ]
%                       false は、周波数単位がヘルツであることを指定します。
%
%   Fs                  [ {Normalized} または正の double ]
%                       'NormalizedFrequency' が false に設定されている場合のみ
%                       指定可能なサンプリング周波数です。
%
%   SpectrumRange        [ {Half} | Whole ]
%                       Half は、ナイキスト範囲の半分のみを使用することを示します。
%
%   Hopts オブジェクトは、<a href="matlab:help spectrum/pseudospectrum">pseudospectrum</a> メソッドへの
%   入力引数として渡すことが可能です。
%
%   Hopts = PSEUDOSPECTRUMOPTS(Hs,X) は、Hopts にデータ特有のデフォルトオプションを
%   返すために X に指定されたデータを使用します。
%
%   参考 SPECTRUM/PSDOPTS, SPECTRUM/MSSPECTRUMOPTS, SPECTRUM, DSPDATA.


%   Copyright 1988-2007 The MathWorks, Inc.
