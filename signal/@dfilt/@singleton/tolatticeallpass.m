function Hd2 = tolatticeallpass(Hd);
%TOLATTICEALLPASS  Convert to lattice allpass.
%   Hd2 = TOLATTICEALLPASS(Hd) converts discrete-time filter Hd to lattice
%   allpass filter Hd2.

%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.3.4.2 $  $Date: 2010/12/06 00:06:54 $
  
if ~isallpass(Hd),
    error(message('signal:dfilt:singleton:tolatticeallpass:DFILTErr'));
end

[b,a] = tf(Hd);
k = tf2latc(b,a);
Hd2 = dfilt.latticeallpass(k);
