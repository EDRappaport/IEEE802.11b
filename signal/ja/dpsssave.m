%DPSSSAVE  離散扁長回転楕円体列をデータベースに保存
%
%   DPSSSAVE(NW,E,V) は、E の列内のデータ列とベクトル V 内のそれらに対応する
%   集中度を DPSS MAT-ファイルデータベース dpss.mat に保存します。データ列の
%   長さ N は、E の行数で決定されます。また、NW は、"時間と帯域幅の積" で
%   決定されます。
%
%   STATUS = DPSSSAVE(NW,E,V) は、保存が成功した場合は 0 を、エラーが
%   生じた場合は 1 を返します。
%
%   参考 DPSS, DPSSLOAD, DPSSDIR, DPSSCLEAR.


%   Copyright 1988-2007 The MathWorks, Inc.
