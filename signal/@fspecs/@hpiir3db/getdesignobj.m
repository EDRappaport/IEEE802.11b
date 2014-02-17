function designobj = getdesignobj(~, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.8.1 $  $Date: 2011/04/02 00:57:10 $

%#function fmethod.iirmaxflathp
designobj.butter = 'fmethod.iirmaxflathp';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
