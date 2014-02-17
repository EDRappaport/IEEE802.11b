function [x, y] = thispassbandzoom(this, fcns, Hd, hfm)
%THISPASSBANDZOOM   

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/30 17:33:57 $

[x, y] = thispassbandzoom(this.CurrentFDesign, fcns, Hd, hfm);

rcf = getratechangefactors(this);

if rcf(1) > 1
    switch fcns.getunits()
        case 'db'
            y = y+db(rcf(1));
        case {'linear', 'zerophase'}
            y = y*rcf(1);
        case 'squared'
            y = y*(rcf(1)^2);
    end
end

% [EOF]
