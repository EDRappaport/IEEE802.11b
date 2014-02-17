function isblockrequiredst(~)
%ISBLOCKREQUIREDST Check if block method requires a DST license

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2012/10/29 19:32:36 $

% By default, block requires DST. If certain structure does not, then the
% structure class should override this method. 
[b, ~, ~, errObj] = isspblksinstalled;
if ~b
    error(errObj);
end