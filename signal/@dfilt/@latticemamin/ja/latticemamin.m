%LATTICEMAMIN   最小位相に対するラティス移動平均
%
%   Hd = DFILT.LATTICEMAMIN(K) は、ラティス係数 K を持つ最小位相の離散時間
%   フィルタオブジェクト Hd に対するラティス移動平均 (MA) を作成します。
%   K が設定されていない場合、デフォルトは [] です。この場合、フィルタは
%   出力を変更せずに入力を通します。フィルタオブジェクトの詳細は、
%   <a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> 
%   デモを参照してください。
%
%   係数 k が最小位相フィルタを定義している場合、この構造体の形で得られる
%   フィルタは最小位相フィルタになることに注意してください。係数が最小位相
%   フィルタを定義していない場合は、この構造体の形にしても最小位相フィルタには
%   なりません。
%
%   さらに、Filter Design Toolbox は、Fixed-Point Designer と共に、単精度浮動
%   小数点と固定小数点のサポートを有効にします。フィルタオブジェクトの詳細は、
%   <a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> デモを参照してください。
%
%   % 例:
%   k = [.66 .7 0.44];
%   Hd = dfilt.latticemamin(k)
%   ismin = isminphase(Hd)
%   realizemdl(Hd);    % Simulink が必要
%
%   参考 DFILT/STRUCTURES, TF2LATC


%   Copyright 1988-2008 The MathWorks, Inc.
