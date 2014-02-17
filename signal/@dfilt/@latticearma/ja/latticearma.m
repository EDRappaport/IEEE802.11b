%LATTICEARMA  ラティス自己回帰移動平均
%
%   Hd = DFILT.LATTICEARMA(K, V) は、ラティス係数 K とラダー係数 V を持つ
%   ラティス自己回帰移動平均 (ARMA) 離散時間フィルタオブジェクト Hd を作成します。
%   K または V が指定されない場合、デフォルトは [] と 1 です。この場合、フィルタ
%   は出力を変更せずに入力を通します。フィルタオブジェクトの詳細は、
%   <a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> 
%   デモを参照してください。
%
%   Filter Design Toolbox は、Fixed-Point Designer と共に、単精度浮動小数点と
%   固定小数点のサポートを有効にすることに注意してください。フィルタオブジェクト
%   の詳細は、<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> デモを参照してください。
%
%   % 例:
%   [b,a] = butter(3,.5);
%   [k,v] = tf2latc(b,a);
%   Hd = dfilt.latticearma(k,v)
%   realizemdl(Hd);    % Simulink が必要
%
%   参考 DFILT/STRUCTURES, TF2LATC


%   Copyright 1988-2008 The MathWorks, Inc.
