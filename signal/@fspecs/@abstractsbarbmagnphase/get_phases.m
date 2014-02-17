function phases = get_phases(this, ~)
%GET_PHASES PreGet function for the 'phases' property.

%   Copyright 2005-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/27 01:20:45 $

% Linear Phase
phases = angle(this.FreqResponse);


% [EOF]
