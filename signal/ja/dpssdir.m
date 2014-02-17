%DPSSDIR  離散扁長回転楕円体列データベースディレクトリ
%
%   DPSSDIR は、dpss.mat 内に保存されているデータ列のディレクトリを表示します。
%   DPSSDIR(N) は、長さ N の保存されているデータ列を表示します。
%   DPSSDIR(NW,'NW') は、時間と帯域幅の積が NW の保存されている列を表示します。
%   DDPS-SDIR(N,NW) は、長さが N で時間と帯域幅の積が NW の保存されている
%   データ列を表示します。
%
%   INDEX = DPSSDIR は、DPSS データベースを記述する構造体配列です。出力が
%   ないものについては、N と NW オプションを渡してフィルタ処理された 
%   INDEX を得ます。
%
%   参考 DPSS, DPSSSAVE, DPSSLOAD, DPSSCLEAR.


%   Copyright 1988-2007 The MathWorks, Inc.
