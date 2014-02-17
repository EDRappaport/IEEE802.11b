function loadmetadata(this, s)
%LOADMETADATA   Load the metadata.

%   Copyright 1988-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/10/01 21:28:41 $

if isstruct(s)
    hfd = s.fdesign;
    designMethodStr = '';
    if s.version.number > 0
        if s.version.number > 2 && isfield(s, 'measurements')
            setmeasurements(this, s.measurements);
            if isfield(s, 'privdesignmethod')
                designMethodStr = s.designmethod;
            end
        end
        hfm = s.fmethod;
    else
        hfm = [];
    end
else
    hfd = getfdesign(s);
    hfm = getfmethod(s);
    designMethodStr = s.privdesignmethod;
end

% Add the SystemObject property if it applies
if ~isempty(hfm) && isa(hfm,'fmethod.abstractdesign')
  addsysobjdesignopt(hfm);
end

setfdesign(this, hfd);
setfmethod(this, hfm);
set(this, 'privdesignmethod', designMethodStr);

% [EOF]
