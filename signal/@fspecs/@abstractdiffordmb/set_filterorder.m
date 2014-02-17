function filterorder = set_filterorder(~, filterorder)
%SET_FILTERORDER PreSet function for the 'filterorder' property.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:15 $

if rem(filterorder,2),
    error(message('signal:fspecs:abstractdiffordmb:set_filterorder:InvalidOrder'));
end


% [EOF]
