function lthoctave = set_bandsperoctave(this, lthoctave)
%SET_BANDSPEROCTAVE   PreSet function for the 'bandsperoctave' property.

%   Author(s): V. Pellissier
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/10/18 03:24:50 $

if isprop(this.CurrentSpecs, 'privBandsPerOctave')
    set(this.CurrentSpecs, 'privBandsPerOctave', lthoctave);
end


% [EOF]
