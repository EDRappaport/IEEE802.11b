function delay = super_set_delay(this, delay)
%SUPER_SET_DELAY   PreSet function for the 'delay' property.

%   Author(s): V. Pellissier
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:29 $

this.reffracdelay = delay;

% Quantize the fracdelay
quantizefd(this);

delay = [];

% [EOF]
