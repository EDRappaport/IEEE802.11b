function designobj = getdesignobj(this, str)
%GETDESIGNOBJ Get the design object
%   OUT = GETDESIGNOBJ(ARGS) <long description>

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/01/06 22:58:37 $

%#function fmethod.sqrtrcosmin
designobj.window = 'fmethod.sqrtrcosmin';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
