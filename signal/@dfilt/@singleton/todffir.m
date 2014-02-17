function Hd2 = todffir(Hd);
%TODFFIR  Convert to direct-form FIR.
%   Hd2 = TODFFIR(Hd) converts discrete-time filter Hd to direct-form FIR
%   filter Hd2.

%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.2.4.2 $  $Date: 2010/12/06 00:06:51 $
  
if ~isfir(Hd)
  error(message('signal:dfilt:singleton:todffir:DFILTErr'));
end
[b,a] = tf(Hd);
Hd2 = dfilt.dffir(b/a(1));
