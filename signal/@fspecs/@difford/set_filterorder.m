function filterorder = set_filterorder(this, filterorder)
%SET_FILTERORDER   PreSet function for the 'filterorder' property.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2010/12/06 00:11:21 $

% When the object is initialized, the FilterOrder is empty and then is set
% to the factory value.  Since it requires the odd order, the constructor
% overwrites it with 31.  To prevent populating lasterr, the condition of
% empty FilterOrder is added here.  The user cannot set the FilterOrder to
% be empty once the object is constructed.

if ~isempty(this.FilterOrder) && rem(filterorder,2)==0,
    error(message('signal:fspecs:difford:set_filterorder:InvalidOrder'));
end

% [EOF]
