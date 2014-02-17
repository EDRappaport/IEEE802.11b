function designobj = getdesignobj(~, str)
%GETDESIGNOBJ   Get the design object.

%   Copyright 2005-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2012/01/06 22:58:42 $

%#function fmethod.invfreqz2
designobj.iirls = 'fmethod.invfreqz2';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
