function designobj = getdesignobj(this, str)
%GETDESIGNOBJ Get the design object
%   OUT = GETDESIGNOBJ(ARGS) <long description>

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2012/01/06 22:58:34 $

%#function fmethod.rcosmin
designobj.window = 'fmethod.rcosmin';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
