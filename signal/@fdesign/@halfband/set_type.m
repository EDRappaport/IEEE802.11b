function type = set_type(this, type)
%SET_TYPE PreSet function for the 'type' property

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/10/23 18:47:58 $

this.privType = type;
updatecurrentspecs(this)

% [EOF]
