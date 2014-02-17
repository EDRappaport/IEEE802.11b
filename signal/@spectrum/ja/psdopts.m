%PSDOPTS  パワースペクトル密度 (PSD) オプションのオブジェクト
%
%   Hopts = PSDOPTS(Hs) は、Hs に指定された PSD 推定器に対して Hopts に 
%   PSD オプションのオブジェクトを返します。
%
%   有効な PSD 推定器:
%           <a href="matlab:help spectrum.periodogram">periodogram</a>
%           <a href="matlab:help spectrum.mcov">mcov</a>
%           <a href="matlab:help spectrum.welch">welch</a>
%           <a href="matlab:help spectrum.mtm">mtm</a>
%           <a href="matlab:help spectrum.burg">burg</a>
%           <a href="matlab:help spectrum.yulear">yulear</a>
%           <a href="matlab:help spectrum.cov">cov</a>
%
%   Hopts は、次のプロパティを含みます:
%
%   プロパティ            有効な値と説明
%   ---------           ----------------------------
%   FreqPoints          [ {All} | ユーザ定義 ]
%                       Full は、すべてのナイキスト範囲を示し、動的に 
%                       NFFT プロパティを作成します。ユーザ定義は、
%                       動的に FrequencyVector プロパティを作成し、
%                       ユーザがその点で psd を評価するための周波数を
%                       指定することを許可します。
%
%   NFFT                [ Auto | {Nextpow2} または正の整数]
%                       FFT 点数。Auto は、256 の最大、または入力 (または 
%                       Welch のセグメント) の長さを使用します。
%                       Nextpow2 は Auto と同じですが、次の 2 のべき乗を
%                       使用します。
%
%   FrequencyVector     [ Fs より小さい実数の数値で double のベクトル ]
%                       psd を評価する周波数のベクトルを指定します。
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
%   Hopts オブジェクトは、<a href="matlab:help spectrum/psd">psd</a> メソッドへの
%   入力引数として渡すことが可能です。
%
%   Hopts = PSDOPTS(Hs,X) は、Hopts にデータ特有のデフォルトオプションを返すために 
%   X に指定されたデータを使用します。
%
%   参考 SPECTRUM/MSSPECTRUMOPTS, SPECTRUM/PSEUDOSPECTRUMOPTS, SPECTRUM, 
%        DSPDATA.


%   Copyright 1988-2007 The MathWorks, Inc.
