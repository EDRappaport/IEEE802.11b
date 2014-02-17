%AUTOSCALE  ダイナミックレンジのスケーリング
%
%   AUTOSCALE(Hd,X) は、フィルタ Hd の各ノードに対してダイナミックレンジの
%   スケーリングを与えます。このメソッドは、浮動小数点のフィルタを通して
%   信号 X を実行し、シミュレーションの範囲をカバーして精度が最大化される
%   ような小数部の長さを設定するために、シミュレーションから得られたデータの
%   最大と最小を使用します。語長は変更されません。
%
%   HNEW = AUTOSCALE(Hd,X) は、出力が要求された場合、新規フィルタはスケーリング
%   された小数部の長さで生成され、オリジナルのフィルタは変更されません。
%
%   % 例:バンドパス IIR 楕円フィルタのオートスケール
%   Hd = design(fdesign.bandpass, 'ellip');
%   Hd = convert(Hd, 'latticearma');
%   Hd.Arithmetic = 'fixed';
%   rand('state', 4)
%   x = rand(100,10);
%   Hd(2) = autoscale(Hd,x);
%   hfvt = fvtool(Hd,'Analysis','magestimate','Showreference','off');
%   legend(hfvt,'Before Autoscaling', 'After AutoScaling')
%
%   より詳しい例については、<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\iirautoscaledemo.html'])">Fixed-Point Scaling of an Elliptic IIR Filter</a>
%   と <a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\iirfloat2fixeddemo.html'])">Floating-point to Fixed-Point Conversion of IIR Filters</a> 
%   のデモを参照してください。
%
%   参考 DFILT


%   Copyright 2006-2007 The MathWorks, Inc.
