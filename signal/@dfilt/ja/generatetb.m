%GENERATETB  HDL テストベンチを生成
%
%   GENERATETB(Hb, TBTYPE) は、フィルタに対する入力の刺激信号として、インパルス、
%   ステップ、ランプ、chirp、またはノイズ波形のいずれか、またはすべてを使って、
%   GENERATEHDL(Hb) で生成されたフィルタを機能的に検証する VHDL コード、Verilog 
%   コード、または ModelSim の .do ファイルを自動的に生成します。TBTYPE は、
%   'VHDL', 'Verilog', 'ModelSim' のいずれか、または、これらのいずれか、あるいは
%   すべてを含むセル配列です。デフォルトのファイル名は、追加された '_tb' を
%   もつフィルタ変数の名前です。たとえば、選択したテストベンチに依存し、VHDL に
%   対して Hb_tb.vhd、Verilog に対して Hb_tb.v、ModelSim に対して Hb_tb.do 
%   ファイルです。ファイルは、HDL のターゲットディレクトリ、デフォルトでは、
%   カレントディレクトリの下の 'hdlsrc'に書き込まれます。このディレクトリは
%   存在しない場合、作成されます。
%
%   GENERATETB(Hb, TBTYPE, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) は、
%   パラメータ/値の組み合わせでテストベンチを生成します。GENERATETB に対する
%   有効なプロパティと値は、Filter Design HDL Coder のドキュメンテーションの 
%   "Property Reference" の節にリストされています。
%
%   例:
%   % フィルタのセットアップ
%   h = firceqrip(30,0.4,[0.05 0.03]);
%   Hb = dfilt.dffir(h);
%   Hb.arithmetic = 'fixed';
%   generatehdl(Hb);
%
%   % テストベンチの例
%   generatetb(Hb, 'ModelSim');
%   generatetb(Hb,'VHDL','TestBenchName','MyTestBench');
%   generatetb(Hb,{'ModelSim','VHDL'}, 'TestBenchStimulus',{'impulse','chirp'});
%   generatetb(Hb,'VHDL','TestBenchUserStimulus', sin(2*pi*[0:0.01:1]));
%
%   参考 GENERATEHDL, GENERATETBSTIMULUS, FDHDLTOOL


%   Copyright 2003-2007 The MathWorks, Inc.
