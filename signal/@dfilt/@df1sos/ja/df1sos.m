%DF1SOS  直接型 I, 2 次型
%
%   Hd = DFILT.DF1SOS(SOS) は、<a href="matlab: help zp2sos">zp2sos</a> で定義される SOS 行列に
%   与えられた係数を使って離散時間の 2 次型の直接型 I フィルタオブジェクト 
%   Hd を返します。
%
%   Hd = DFILT.DF1SOS(b1,a1,b2,a2,...) は、b1 と a1 ベクトルに与えられた 
%   1 番目のセクション、b2 と a2ベクトルに与えられた 2 番目のセクション、... に
%   対する係数を使って離散時間の 2 次型の直接型 I フィルタオブジェクト Hd を
%   返します。
%
%   Hd = DFILT.DF1SOS(...,g) は、ゲインベクトル g を含みます。g の要素は
%   各セクションのゲインです。g の最大長は、セクションの数に 1 を加えた値です。
%   g を指定しない場合、すべてのゲインがデフォルト値 1 になります。フィルタ
%   オブジェクトの詳細は、<a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> デモ
%   を参照してください。
%
%   Filter Design Toolbox がインストールされている場合、通常は、明確に DFILT 
%   フィルタを作成しないことに注意してください。代わりに、<a href="matlab:help fdesign">FDESIGN</a> を
%   使用した設計の結果としてこれらのフィルタを得ます。
%
%   さらに、Filter Design Toolbox は、Fixed-Point Designer と共に、単精度
%   浮動小数点と固定小数点のサポートを有効にします。フィルタオブジェクトの
%   詳細は、<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> デモを参照してください。
%
%   % 例 #1:直接インスタンス化
%   [z,p,k] = ellip(4,1,60,.4);
%   [s,g] = zp2sos(z,p,k);
%   Hd = dfilt.df1sos(s,g)
%   realizemdl(Hd)    % Simulink が必要
%
%   % 例 #2:デフォルトの仕様で楕円ローパスフィルタを設計
%   Hd = design(fdesign.lowpass, 'ellip', 'FilterStructure', 'df1sos');
%   fvtool(Hd)                % フィルタの解析
%   input = randn(100,1);
%   output = filter(Hd,input); % 楕円フィルタを通してデータを処理
%
%   参考 DFILT/STRUCTURES.


%   Copyright 1988-2008 The MathWorks, Inc.
