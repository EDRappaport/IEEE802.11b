function filterOrder = set_filterorder(this, filterOrder)
%SET_FILTERORDER PreSet function for the 'FilterOrder' property
%   OUT = SET_FILTERORDER(ARGS) <long description>

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:11:41 $

if mod(filterOrder, 2)
    error(message('signal:fspecs:psgaussnsym:set_filterorder:InvalidFilterOrder'));
end

% [EOF]
