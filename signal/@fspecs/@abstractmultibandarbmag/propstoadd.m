function p = propstoadd(this)
%PROPSTOADD Return the properties to add to the parent object.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/02/21 07:09:03 $

p = [{'NormalizedFrequency', 'Fs'}, orderprop(this), {'NBands'}];
for i=1:this.NBands,
    p = [p {sprintf('%s%d%s','B',i,'Frequencies'), ...
        sprintf('%s%d%s','B',i,'Amplitudes')}]; %#ok<AGROW>
end

% [EOF]
