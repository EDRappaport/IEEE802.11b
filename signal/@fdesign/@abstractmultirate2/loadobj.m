function this = loadobj(s)
%LOADOBJ   Load this object.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.8.1 $  $Date: 2005/08/04 18:03:29 $

this = feval(s.class);

for indx = 1:length(s.AllFDesign)
    hFDesign(indx) = copy(s.AllFDesign(indx));
end

set(this, 'AllFDesign', hFDesign);

dt = s.Response;

% Remove the current FDesign because this is carried over from the default
% constructor.
this.CurrentFDesign = [];

% Update the current FDesign by setting the design type.
if strcmpi(this.Response, dt)
    updatecurrentfdesign(this);
else
    set(this, 'Response', dt);
end

if isstruct(s)
    rcf = s.ratechangefactors;
else
    rcf = s.getratechangefactors;
end

setratechangefactors(this, rcf);


% [EOF]
