function b = genmcode(h, d)
%GENMCODE Generate MATLAB code

%   Author(s): J. Schickler
%   Copyright 1988-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/02/15 01:13:59 $

[params, values, descs, str] = fir1_genmcode(d);

b = sigcodegen.mcodebuffer;

b.addcr(b.formatparams({'N', 'Fc', params{:}}, ...
    {getmcode(d, 'order'), getmcode(d, 'Fc'), values{:}}, ...
    {'', '', descs{:}}));
b.cr;
b.addcr(str);
b.cr;
b.addcr(designdesc(d));
if rem(d.order, 2) == 1
    b.addcr('b  = fir1(N, Fc%s, ''high'', win, flag, ''h'');', getfsstr(d));
else
    b.addcr('b  = fir1(N, Fc%s, ''high'', win, flag);', getfsstr(d));
end
b.add('Hd = dfilt.dffir(b);');

% [EOF]
