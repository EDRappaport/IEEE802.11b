%HELP  特定のフィルタ設計アルゴリズムに対するヘルプを表示
%
%   HELP(D, METHOD) は、フィルタデザイナ D の現在の設定に対する設計
%   アルゴリズム METHOD に対するヘルプを表示します。METHOD は、
%   <a href="matlab:help fdesign/designmethods">DESIGNMETHODS</a> で返される文字列の
%   いずれかでなければなりません。
%
%   % 例 - ローパスのバタワースフィルタに対するヘルプを取得します。
%   d = fdesign.lowpass;
%   designmethods(d)
%   help(d,'butter')
%
%   参考 FDESIGN, FDESIGN/DESIGN, FDESIGN/DESIGNMETHODS, FDESIGN/DESIGNOPTS.


%   Copyright 2005-2007 The MathWorks, Inc.
