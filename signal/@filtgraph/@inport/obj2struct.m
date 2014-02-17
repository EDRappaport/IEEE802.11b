function s = obj2struct(this)
%OBJ2STRUCT <short description>

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/11/17 12:41:24 $

s = get(this);
if ~isempty(this.from)
    s.from = get(this.from);
end 

% [EOF]
