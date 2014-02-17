function b = genmcode(h, d)
%GENMCODE Generate MATLAB code

%   Author(s): J. Schickler
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2010/01/25 22:51:12 $

[params, values, descs, iargs] = abstract_genmcode(h, d);

b = sigcodegen.mcodebuffer;

b.addcr(b.formatparams({'N', params{:}}, ...
    {getmcode(d, 'Order'), values{:}}, {'', descs{:}}));
b.cr;
b.addcr(designdesc(d));
b.addcr('b  = firls(N, %s);', iargs);
b.add('Hd = dfilt.dffir(b);');

% [EOF]