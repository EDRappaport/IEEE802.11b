function [params, values, descs, iargs] = genmcode(h, d)
%GENMCODE Generate MATLAB code that designs a lowpass filter using GREMEZ

%   Author(s): J. Schickler
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2010/01/25 22:50:37 $

mu = get(d, 'magUnits'); set(d, 'magUnits', 'linear');

params = {'Fstop1', 'Fpass1', 'Fpass2', 'Fstop2', 'Dpass1', 'Dpass2'};
values = {getmcode(d, 'Fstop1'), getmcode(d, 'Fpass1'), getmcode(d, 'Fpass2'), ...
        getmcode(d, 'Fstop2'), getmcode(d, 'Dpass1'), getmcode(d, 'Dpass2')};
descs  = {'', '', '', '', '', ''};

set(d, 'magUnits', mu);

[fsstr, fs] = getfsstr(d);

iargs = sprintf('[0 Fstop1 Fpass1 Fpass2 Fstop2 %s]%s, %s, %s', ...
    fs, fsstr, '[1 1 0 0 1 1]', '[Dpass1 1 Dpass2]');

% [EOF]
