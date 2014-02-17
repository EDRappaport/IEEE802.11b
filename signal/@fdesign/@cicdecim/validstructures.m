function vs = validstructures(~, ~, varargin)
%VALIDSTRUCTURES   

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/10/01 21:29:13 $

vs_str = {'cicdecim'};

if nargin < 2
    vs.design = vs_str;
else
    vs = vs_str;
end

% [EOF]
