function p = propstoadd(this)
%PROPSTOADD Return the properties to add to the parent object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/02/21 07:09:39 $

p = [{'NormalizedFrequency', 'Fs'}, {'NBands'}];
for i=1:this.NBands,
    p = [p {sprintf('%s%d%s','B',i,'Frequencies'), ...
        sprintf('%s%d%s','B',i,'Amplitudes'), ...
        sprintf('%s%d%s','B',i,'Ripple')}]; %#ok<*AGROW>
end

% [EOF]
