function groupDelay = set_groupdelay(~, groupDelay)
%SET_GROUPDELAY PreSet function for the 'GroupDelay' property.

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/12/27 01:21:08 $

% Force row vector
groupDelay = groupDelay(:).';

% [EOF]
