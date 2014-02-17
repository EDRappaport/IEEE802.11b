function Hd2 = toscalar(Hd);
%TOSCALAR  Convert to scalar.
%   Hd2 = TOSCALAR(Hd) converts discrete-time filter Hd to scalar filter Hd2. 

%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.2.4.2 $  $Date: 2010/12/06 00:06:58 $
  
if ~isscalar(Hd)
  error(message('signal:dfilt:singleton:toscalar:DFILTErr'));
end
  
[b,a] = tf(Hd);
Hd2 = dfilt.scalar(b/a(1));
