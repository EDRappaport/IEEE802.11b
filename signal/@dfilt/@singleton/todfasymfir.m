function Hd2 = todfasymfir(Hd);
%TODFASYMFIR  Convert to antisymmetric FIR.
%   Hd2 = TODFASYMFIR(Hd) converts discrete-time filter Hd to
%   antisymmetric FIR filter Hd2.

%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.4.4.2 $  $Date: 2010/12/06 00:06:50 $
  
if ~isfir(Hd)
  error(message('signal:dfilt:singleton:todfasymfir:DFILTErr'));
end
[b,a] = tf(Hd);
Hd2 = dfilt.dfasymfir(b/a(1));
