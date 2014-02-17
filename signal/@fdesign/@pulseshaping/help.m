function help(this, designmethod)
%HELP   Provide help for the specified design method.

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:49 $

if nargin < 2
    help('fdesign');
elseif isdesignmethod(this.PulseShapeObj, designmethod)
    help(this.PulseShapeObj, designmethod);
else
    error(message('signal:fdesign:pulseshaping:help:invalidDesignMethod', designmethod));
end

% [EOF]
