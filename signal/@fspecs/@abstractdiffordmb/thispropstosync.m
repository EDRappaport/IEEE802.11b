function p = thispropstosync(~, p)
%THISPROPSTOSYNC   

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:16 $

% Remove FilterOrder because it must be even for certain specs and odd for
% others.
p(strcmp('FilterOrder',p)) =[];

% [EOF]
