function b = genmcode(~, d)
%GENMCODE Generate MATLAB code

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.2.6.4 $  $Date: 2012/09/20 22:35:30 $

b = sigcodegen.mcodebuffer;

b.addcr(b.formatparams({'Nb', 'Na', 'F3dB'}, ...
    {getmcode(d, 'numOrder'), getmcode(d, 'denOrder'), getmcode(d, 'Fc')}));
b.cr;

if strcmpi(d.freqUnits, 'normalized (0 to 1)'),
    fsinput = '';
else
    fsinput = ', Fs';
end

b.addcr('h  = fdesign.lowpass(''Nb,Na,F3dB'', Nb, Na, F3dB%s);', fsinput);
b.add('Hd = design(h, ''butter'');');

