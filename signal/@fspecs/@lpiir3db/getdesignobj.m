function designobj = getdesignobj(~, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2008-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/04/02 00:57:50 $

%#function fmethod.iirmaxflatlp
designobj.butter = 'fmethod.iirmaxflatlp';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
