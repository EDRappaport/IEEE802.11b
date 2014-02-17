function c = cost(this, archobj)
%COST   

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2005/12/22 18:56:57 $

c = [];
if nargin < 2,
    for i=1:length(this),
        c = [c evalcost(this(i))];
    end
end

% [EOF]
