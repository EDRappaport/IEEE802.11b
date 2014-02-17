%DF1  直接型 I
%
%   Hd = DFILT.DF1(NUM, DEN) は、分子係数 NUM と分母係数 DEN を持つ離散時間の
%   直接型 I フィルタオブジェクト Hd を作成します。分母 DEN(1) の最初の係数は、
%   0 にはなりません。フィルタオブジェクトの詳細は、<a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> 
%   デモを参照してください。
%
%   Filter Design Toolbox は、Fixed-Point Designer と共に、単精度浮動小数点と
%   固定小数点のサポートを有効にすることに注意してください。フィルタオブジェクト
%   の詳細は、<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> デモを参照してください。
%
%   さらに、IIR フィルタの直接型の構造は、数値的な問題を起こす可能性がある
%   ことに注意してください。多くの場合、伝達関数の作成を避け、<a href="matlab:help dfilt.df1sos">2 次型</a> 
%   を使用することで、良い結果を得ることができます。
%
%   % 例 #1:直接インスタンス化
%   [b,a] = butter(4,.5);
%   Hd = dfilt.df1(b,a)
%
%   % 例 #2:2 次型の 10 次のローパスフィルタを設計
%   f = fdesign.lowpass('N,F3dB',10,.5);  % 仕様
%   Hd = design(f, 'butter', 'Filterstructure', 'df1sos')
%
%   参考 DFILT/STRUCTURES.


%   Copyright 1988-2008 The MathWorks, Inc.
