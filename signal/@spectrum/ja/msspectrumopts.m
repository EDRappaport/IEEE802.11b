%MSSPECTRUMOPTS  平均二乗スペクトル (MSS) オプションのオブジェクト
%
%   Hopts = MSSPECTRUMOPTS(Hs) は、Hs に指定された MSS 推定器に対して 
%   Hopts に MSS オプションのオブジェクトを返します。
%
%   有効な MSS 推定器:
%           <a href="matlab:help spectrum.periodogram">periodogram</a>
%           <a href="matlab:help spectrum.welch">welch</a>
%
%   Hopts は、次のプロパティを含みます:
%
%   プロパティ            有効な値と説明
%   ---------           ----------------------------
%   FreqPoints          [ {All} | ユーザ定義 ]
%                       Full は、すべてのナイキスト範囲を示し、動的に NFFT 
%                       プロパティを作成します。ユーザ定義は、動的に 
%                       FrequencyVector プロパティを作成し、ユーザがその点で
%                       平均二乗スペクトルを評価する周波数のを指定することを
%                       許可します。
%
%   NFFT                [ Auto | {Nextpow2} または正の整数]
%                       FFT 点数。Auto は、最大の 256、または入力 (または 
%                       Welch のセグメント) の長さを使用します。
%                       Nextpow2 は Auto と同じですが、次の 2 のべき乗を
%                       使用します。
%
%   FrequencyVector     [ Fs より小さい実数の数値で double のベクトル ]
%                       平均二乗スペクトルを評価する周波数のベクトルを
%                       指定します。
%
%   NormalizedFrequency [ {true} | false ]
%                       false は、周波数単位がヘルツであることを指定します。
%
%   Fs                  [ {Normalized} または正の double ]
%                       'NormalizedFrequency' が false に設定されている
%                       場合のみ指定可能なサンプリング周波数です。
%
%   SpectrumType        [ {Onesided} | Twosided ]
%                       Onesided は、すべての信号パワーがナイキスト範囲の
%                       半分に含まれることを示します。
%
%   Hopts オブジェクトは、<a href="matlab:help spectrum/msspectrum">msspectrum</a> 
%   メソッドへの入力引数として渡すことが可能です。
%
%   Hopts = MSSPECTRUMOPTS(Hs,X) は、Hopts にデータ特有のデフォルトオプションを
%   返すために X に指定されたデータを使用します。
%
%   参考 SPECTRUM/PSDOPTS, SPECTRUM/PSEUDOSPECTRUMOPTS, SPECTRUM, DSPDATA.


%   Copyright 1988-2007 The MathWorks, Inc.
