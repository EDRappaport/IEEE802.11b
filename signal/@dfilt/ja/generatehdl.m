%GENERATEHDL  HDL を生成
%
%   GENERATEHDL(Hb) は、量子化されたフィルタ Hb に対する VHDL または Verilog 
%   コードを自動的に生成します。デフォルト言語は VHDL で、Verilog を生成する
%   には、プロパティ/値の組み合わせ 'TargetLanguage','Verilog' を与えます。
%   デフォルトのファイル名は、フィルタの変数名、たとえば、VHDL に対して Hb.vhd、
%   Verilog に対して Hb.v です。ファイルは、HDL のソースディレクトリ、デフォルト
%   では、カレントディレクトリの下の 'hdlsrc'に書き込まれます。このディレクトリ
%   は、必要に応じて作成されます。
%
%   GENERATEHDL(Hb, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) は、
%   パラメータ/値の組み合わせで HDL コードを生成します。GENERATEHDL に対する
%   有効なプロパティと値は、Filter Design HDL Coder のドキュメンテーションの 
%   "Property Reference" の節にリストされています。
%
%   例:
%   filtdes = fdesign.lowpass('N,Fc,Ap,Ast',30,0.4,0.05,0.03,'linear');
%   Hb = design(filtdes,'filterstructure','dffir');
%   Hb.arithmetic = 'fixed';
%   generatehdl(Hb);
%   generatehdl(Hb,'TargetLanguage','Verilog');
%   generatehdl(Hb,'Name','myfiltername','TargetDirectory','mysrcdir');
%   generatehdl(Hb,'InputPort','adc_data','OutputPort','dac_data');
%   generatehdl(Hb,'AddInputRegister','on','AddOutputRegister','off');
%   generatehdl(Hb,'OptimizeForHDL','on','CoeffMultipliers','csd');
%   generatehdl(Hb,'SerialPartition', 31);
%   generatehdl(Hb,'SerialPartition', [12 11 8], 'ReuseAccum', 'on');
%
%   参考 GENERATEHDLGUI, GENERATETB, GENERATETBSTIMULUS.


%   Copyright 2003-2007 The MathWorks, Inc.
