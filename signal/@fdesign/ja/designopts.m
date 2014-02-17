%DESIGNOPTS  デフォルトの設計パラメータを返す
%
%   OPTS = DESIGNOPTS(D, METHOD) は、設計メソッド METHOD で使用される
%   デフォルトの設計パラメータを持つ構造体を返します。METHOD は、
%   <a href="matlab:help fdesign/designmethods">DESIGNMETHODS</a> で返される文字列の
%   いずれかでなければなりません。
%
%   設計パラメータの説明を得るには、HELP(D, METHOD) を使用してください。
%
%   % 例 - 最小次数のローパスバタワースフィルタに対する設計オプションを
%   %      取得します。
%   d = fdesign.lowpass;
%   designmethods(d)
%   opts = designopts(d, 'butter')
%   help(d,'butter')
%
%   参考 FDESIGN, FDESIGN/DESIGN, FDESIGN/DESIGNMETHODS, FDESIGN/HELP.


%   Copyright 2005-2007 The MathWorks, Inc.
