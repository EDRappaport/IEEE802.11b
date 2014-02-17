function b = genmcode(h, d)
%GENMCODE Generate MATLAB code

%   Author(s): J. Schickler
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.4.3 $  $Date: 2010/01/25 22:52:57 $

b = abstract_genmcode(h, d);
b.cr;
b.addcr(designdesc(d));
b.addcr('b  = firhalfband(''minorder'', Fpass%s, Dpass);', getfsstr(d));
b.add('Hd = dfilt.dffir(b);');

% [EOF]
