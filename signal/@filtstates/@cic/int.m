function intvalue = int(this)
%INT   Return the integer.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/05/13 18:13:14 $

% Loop over each channel.
validate(this);

[nsections nchannels] = size(this.Integrator);

intvalue = {};

for indx = 1:nchannels
    for jndx = 1:nsections
        intvalue{end+1} = [int(this.Integrator(jndx, indx)); ...
            int(this.Comb(jndx, indx))];
    end
end

% Line up the channels in a row.
intvalue = [intvalue{:}];

% [EOF]
