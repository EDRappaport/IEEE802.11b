function designobj = getdesignobj(this, str)
%GETDESIGNOBJ Get the design object
%   OUT = GETDESIGNOBJ(ARGS) <long description>

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/01/06 22:58:39 $

%#function fmethod.sqrtrcoswin
designobj.window = 'fmethod.sqrtrcoswin';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
