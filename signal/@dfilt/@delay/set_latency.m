function latency = set_latency(this, latency)
%SET_LATENCY   PreSet function for the 'latency' property.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:10:08 $

if isempty(latency) || (isnumeric(latency) && (round(latency)~=latency) || latency<0) || ...
        isnan(latency) || ~isfinite(latency),
    error(message('signal:dfilt:delay:set_latency:InvalidLatency', 'Latency'));
end
this.privnstates = latency;
reset(this);

% clear metadata
clearmetadata(this);

latency = [];



% [EOF]
