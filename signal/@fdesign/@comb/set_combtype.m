function combtype = set_combtype(this, combtype)
%SET_COMBTYPE PreSet function for the 'CombType' property

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2008/10/31 07:00:48 $

%This function connects the set value of CombType in fdesign with the value
%in fspecs
set(this.CurrentSpecs, 'CombType', combtype);

% [EOF]
