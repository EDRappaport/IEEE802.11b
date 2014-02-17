%DESIGNMETHODS  フィルタデザイナに対して利用可能な設計メソッドを返す
%
%   M = DESIGNMETHODS(D) は、フィルタデザイナ D と現在の 'Specification' に
%   対する利用可能な設計メソッドを返します。
%
%   M = DESIGNMETHODS(D, 'default') は、フィルタデザイナ D と現在の 
%   'Specification' に対するデフォルトの設計メソッドを返します。
%
%   M = DESIGNMETHODS(D, TYPE) は、文字列 'fir' または 'iir' で指定された 
%   FIR または IIR 設計メソッドのいずれかを返します。デフォルトでは、
%   すべての設計メソッドが示されます。
%
%   M = DESIGNMETHODS(D, 'full') は、それぞれの利用可能な設計メソッドに
%   対する完全な名前を返します。例えば、'butter' は、'Butterworth' になります。
%
%   % 例 #1 - ローパスのフィルタデザイナを作成し、その設計メソッドを確認します。
%   d = fdesign.lowpass('N,Fc',10,12000,48000)
%   m = designmethods(d)
%
%   % 例 #2 - 仕様を変更し、更新したメソッドを確認します。
%   d.Specification = 'Fp,Fst,Ap,Ast';
%   m2 = designmethods(d)
%   m3 = designmethods(d, 'iir')
%   m4 = designmethods(d, 'iir', 'full')
%
%   % 例 #3 - 特定のメソッドのヘルプを取得します。
%   help(d, m2{1})
%
%   参考 FDESIGN, FDESIGN/DESIGN, FDESIGN/DESIGNOPTS, FDESIGN/HELP.


%   Copyright 1999-2007 The MathWorks, Inc.
