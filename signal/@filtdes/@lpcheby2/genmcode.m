function b = genmcode(h, d)
%GENMCODE Generate MATLAB code

%   Author(s): J. Schickler
%   Copyright 1988-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.9 $  $Date: 2010/01/25 22:52:10 $

[Fstop, Astop] = getdesignspecs(h, d);

b = sigcodegen.mcodebuffer;

p = {'N', 'Fstop', 'Astop'};
v = {getmcode(d, 'Order'), getmcode(d, Fstop), getmcode(d, Astop)};

b.addcr(b.formatparams(p,v));
b.cr;
b.addcr(designdesc(d));

b.addcr('h  = fdesign.lowpass(''N,Fst,Ast'', N, Fstop, Astop%s);', getfsinput(d));
b.add('Hd = design(h, ''cheby2'');');

% [EOF]
