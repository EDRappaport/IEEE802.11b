%DFFIRT  直接型 FIR 転置
%
%   Hd = DFILT.DFFIRT(NUM) は、分子係数 NUM を持つ離散時間の直接型対称 FIR 
%   転置フィルタオブジェクト Hd を作成します。フィルタオブジェクトの詳細は、
%   <a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> 
%   デモを参照してください。
%
%   Filter Design Toolbox がインストールされている場合、通常は、明確に DFILT 
%   フィルタを作成しないことに注意してください。代わりに、<a href="matlab:help fdesign">FDESIGN</a> を
%   使用した設計の結果としてこれらのフィルタを得ます。
%
%   さらに、Filter Design Toolbox は、Fixed-Point Designer と共に、単精度
%   浮動小数点と固定小数点のサポートを有効にします。フィルタオブジェクトの詳細は、
%   <a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> 
%   デモを参照してください。
%
%   % 例 #1: 直接インスタンス化
%   b = [0.05 0.9 0.05];
%   Hd = dfilt.dffirt(b)
%   realizemdl(Hd)    % Simulink が必要
%
%   % 例 #2: デフォルトの仕様で等リップルローパスフィルタを設計
%   Hd = design(fdesign.lowpass, 'equiripple', 'Filterstructure', 'dffirt');
%   fvtool(Hd)                % フィルタの解析
%   x = randn(100,1);   % 入力信号
%   y = filter(Hd,x); % フィルタを入力信号に適用
%
%   参考 DFILT/STRUCTURES


%   Copyright 1988-2008 The MathWorks, Inc.
