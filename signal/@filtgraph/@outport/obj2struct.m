function s = obj2struct(this)
%OBJ2STRUCT <short description>

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/11/17 12:41:26 $

s = get(this);
if ~isempty(this.to)
    s.to = get(this.to);
end 

% [EOF]
