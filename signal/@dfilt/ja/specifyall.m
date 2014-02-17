%SPECIFYALL  固定小数点フィルタの設定をすべて指定
%
%   SPECIFYALL(Hd) は、フィルタ Hd 内のすべての設定を直接指定できるよう
%   オブジェクトのプロパティを設定します。true に設定されたすべての
%   オートスケールオプションは false に設定され、すべての "modes" 
%   ('OutputMode', 'ProductMode', 'AccumMode' のような) は 'SpecifyPrecision' 
%   に設定されます。
%
%   SPECIFYALL は、これらのすべてのプロパティを 1 対 1 で変更するための
%   ショートカットとして利用されます。
%
%   SPECIFYALL(Hd,false) は、基本的に SPECIFYALL(Hd) の反対です。すべての
%   オートスケールオプションを true に設定し、"modes" をこれらのデフォルト値
%   に設定します。
%
%   SPECIFYALL(Hd,true) は、SPECIFYALL(Hd) と等価です。
%
%   % 例:直接型の構造で実装された FIR フィルタの固定小数点設定のすべてを
%   % 完全に制御します。 
%   f = fdesign.lowpass('N,Fp,Fst,Ast',12,0.4,0.5,20); 
%   Hd = design(f,'equiripple'); Hd.Arithmetic = 'fixed';
%   specifyall(Hd);
%
%   参考 DFILT/REFFILTER, DFILT/DOUBLE, DFILT/COPY.


%   Copyright 2003-2007 The MathWorks, Inc.
