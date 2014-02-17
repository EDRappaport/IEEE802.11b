function this = cost(NMult,NAdd,NStates,MPIS,APIS)
%COST   Construct a COST object.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/08/20 13:26:23 $

this = fdesign.cost;
this.NMult = NMult;
this.NAdd = NAdd;
this.NStates = NStates;
this.MultPerInputSample = MPIS;
this.AddPerInputSample = APIS;

    

% [EOF]
