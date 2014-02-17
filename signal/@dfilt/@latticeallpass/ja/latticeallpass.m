%LATTICEALLPASS  ラティスオールパス
%
%   Hd = DFILT.LATTICEALLPASS(LATTICE) は、ラティス係数 K を持つ離散時間の
%   ラティスオールパスフィルタオブジェクト Hd を作成します。K が設定されて
%   いない場合、デフォルトは [] です。この場合、フィルタは出力を変更せずに
%   入力を通します。フィルタオブジェクトの詳細は、
%   <a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> 
%   デモを参照してください。
%
%   Filter Design Toolbox は、Fixed-Point Designer と共に、単精度浮動小数点と
%   固定小数点のサポートを有効にすることに注意してください。フィルタオブジェクト
%   の詳細は、<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> デモを
%   参照してください。
%
%   % 例:
%   k = [.66 .7 .44];
%   Hd = dfilt.latticeallpass(k)
%   realizemdl(Hd);    % Simulink が必要
%
%   参考 DFILT/STRUCTURES, TF2LATC


%   Copyright 1988-2008 The MathWorks, Inc.
