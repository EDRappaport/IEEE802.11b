%FILTERNORM  デジタルフィルタのノルムの計算
%
%   FILTERNORM(B,A) は、ベクトルB および A における分子の係数と分母の
%   係数により与えられる、デジタルフィルタの L2-ノルムを返します。
%
%   FILTERNORM(B,A,PNORM) は、フィルタの L2-ノルムを返します。PNORM は、
%   2、あるいは、inf のいずれかとなります。デフォルトでは、L2-ノルムが
%   返されます。IIR フィルタの L2-ノルムを計算する場合、FILTERNORM(...,TOL) 
%   は、より高い、あるいは、より低い精度の許容誤差を指定します。
%   デフォルトでは、TOL = 1e-8 です。
%
%   例:
%   % IIR フィルタに対する 1e-10 の許容誤差をもつ L2-ノルムの計算
%   [b,a] = butter(5,.5);
%   L2 = filternorm(b,a,2,1e-10);
%
%   % FIR フィルタに対する無限ノルムの計算
%   b = firpm(30,[.1 .9],[1 1],'Hilbert');
%   Linf = filternorm(b,1,inf); 
%
%   参考 ZP2SOS, NORM.


%   Copyright 1988-2008 The MathWorks, Inc.
