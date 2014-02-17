function constraints = set_constraints(this, constraints)
%SET_CONSTRAINTS PostSet function for the 'constraints' property.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/02/21 07:09:31 $

if isempty(constraints), 
    return; 
end

% There is a listener installed for the privConstraints property. Set it to
% trigger the callback function that will add ripple properties dynamically
% if the band has been specified as constrained. 
this.privConstraints = constraints;