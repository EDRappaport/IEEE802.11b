%DESIGN  仕様からフィルタを設計
%
%   H = DESIGN(D) は、D の仕様からフィルタ H を設計します。アルゴリズムは、
%   与えられた仕様に対して利用可能なものから選択されます。
%
%   DESIGN(...) は、設計したフィルタを可視化するために FVTool を起動します。
%
%   H = DESIGN(D, 'FIR') は、FIR 設計を行います。このメソッドは、利用可能な 
%   FIR 設計がない場合、エラーになります。
%
%   H = DESIGN(D, 'IIR') は、IIR 設計を行います。このメソッドは、利用可能な 
%   IIR 設計がない場合、エラーになります。
%
%   H = DESIGN(D, 'ALL') は、仕様に対して利用可能な設計のすべてを使って複数の
%   フィルタを設計します。
%
%   H = DESIGN(D, 'ALLFIR') は、仕様に対して利用可能な FIR 設計のすべてを
%   使って複数のフィルタを設計します。
%
%   H = DESIGN(D, 'ALLIIR') は、仕様に対して利用可能な IIR 設計のすべてを
%   使って複数のフィルタを設計します。
%
%   H = DESIGN(D, METHOD) は、文字列 METHOD で指定された設計メソッドを使います。
%   METHOD は、<a href="matlab:help fdesign/designmethods">designmethods</a> で返される文字列の
%   いずれかでなければなりません。デフォルトで使われるアルゴリズムを定義するには、
%   designmethods(D,'default') を使用してください。
%
%   H = DESIGN(D, METHOD, PARAM1, VALUE1, PARAM2, VALUE2, etc.) は、
%   設計メソッドの特定のオプションを指定します。オプションの入力の詳細は、
%   <a href="matlab:help fdesign/help">help(D, METHOD)</a> を使用してください。
%
%   H = DESIGN(D, METHOD, OPTS) は、構造体 OPTS を使って、設計メソッドの
%   特定のオプションを指定します。OPTS は、通常 <a href="matlab:help fdesign/designopts">designopts</a> 
%   から得られ、修正され、その後、DESIGN に入力として指定されます。
%   オプションの入力の詳細は、<a href="matlab:help fdesign/help">help(D, METHOD)</a> を使用してください。
%
%   % 例 #1 - デフォルト (等リップル) メソッドを使ってフィルタを設計し、
%   %         FVTool でフィルタの応答を可視化します。
%   d = fdesign.lowpass('Fp,Fst,Ap,Ast',.2, .22, 1, 60);
%   Hd = design(d)
%   fvtool(Hd)
%   designmethods(d,'default')
%
%   % 例 #2 - 与えられた仕様に対して可能なすべての IIR を設計します。
%   Fs = 48e3; % サンプリング周波数は 48 kHz
%   d = fdesign.lowpass('Fp,Fst,Ap,Ast',10000,11000,0.5,80,Fs);
%   designmethods(d, 'iir')
%   Hd = design(d, 'alliir'); % Hd は IIR フィルタのベクトルです
%   fvtool(Hd)
%
%   % 例 #3 - Kaiser ウィンドウのハイパス FIR フィルタを設計します。 
%   d  = fdesign.highpass('Fst,Fp,Ast,Ap',0.35, 0.4,74,1);
%   Hd = design(d, 'kaiserwin');
%   fvtool(Hd)
%
%   % 例 #4 - 傾いた遮断帯域を持つ 50 次の等リップル FIR フィルタを
%   %         設計します。詳細は、help(d, 'equiripple') と入力してください (*)
%   d = fdesign.lowpass('N,Fc,Ap,Ast',50, 0.4, 0.8, 80); 
%   Hd = design(d, 'equiripple', 'StopbandShape', 'linear', 'StopbandDecay', 40); 
%   fvtool(Hd)
%
%   % 例 #5 - 補間 FIR メソッドを使ってローパスフィルタを設計します (*)
%   d = fdesign.decimator(4,'lowpass','Fp,Fst,Ap,Ast',.2, .22, 1 ,60);
%   opts = designopts(d,'ifir');
%   opts.JointOptimization = true;
%   Hd = design(d,'ifir',opts); % Hd は、2 つの直列の FIR フィルタになります
%   fvtool(Hd)
%
%   (*) Filter Design Toolbox が必要
%
%   参考 FDESIGN, FDESIGN/DESIGNMETHODS, FDESIGN/DESIGNOPTS, FDESIGN/HELP.


%   Copyright 2005-2007 The MathWorks, Inc.
