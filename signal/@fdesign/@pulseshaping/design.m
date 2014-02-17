function varargout = design(this, varargin)
%DESIGN Design the pulseshaping object.

%   Copyright 2008-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/10/01 21:29:18 $

% If SystemObject has been passed as an input, remove it and cache its
% value. We do not want to convert the underlying pulseshaping filter to a
% System object yet.
[varargin sysObjFlag] = parsesysobj(this,'design',varargin{:});

% Pass to the design method of the underlying pulseshaping object.
if (nargout < 1)
    design(this.PulseShapeObj, varargin{:});
else
    hd = design(this.PulseShapeObj, varargin{:});
    if sysObjFlag
      hd = sysobj(hd);
    end
    varargout = {hd};        
end

% [EOF]
