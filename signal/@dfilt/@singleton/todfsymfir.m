function Hd2 = todfsymfir(Hd);
%TODFSYMFIR  Convert to direct-form symmetric FIR.
%   Hd2 = TODFSYMFIR(Hd) converts discrete-time filter Hd to
%   direct-form symmetric FIR filter Hd2.

%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.4.4.2 $  $Date: 2010/12/06 00:06:53 $
  
if ~isfir(Hd)
  error(message('signal:dfilt:singleton:todfsymfir:DFILTErr'));
end
[b,a] = tf(Hd);
Hd2 = dfilt.dfsymfir(b/a);
