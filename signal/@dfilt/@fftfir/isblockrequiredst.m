function isblockrequiredst(~)
%ISBLOCKREQUIREDST Check if block method requires a DST license

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2012/10/29 19:33:07 $

[b, ~, ~, errObj] = isspblksinstalled;
if ~b
    error(errObj);
end