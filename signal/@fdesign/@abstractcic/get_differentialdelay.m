function diffd = get_differentialdelay(this, diffd)
%GET_DIFFERENTIALDELAY   PreGet function for the 'differentialdelay'
%property.

%   Author(s): P. Costa
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:20:45 $

diffd = this.privDifferentialDelay;
if isempty(diffd), diffd = 1; end


% [EOF]
