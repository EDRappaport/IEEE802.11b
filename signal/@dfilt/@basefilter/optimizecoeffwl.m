function [Hbest,mrfflag] = optimizecoeffwl(this,varargin)
% This should be a private method.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/05/13 18:09:46 $

% Make sure to work with reference filter in case filter has been quantized
Href = reffilter(this);

try
    [Hbest,mrfflag] = optimizecoeffwlfir(this,Href,varargin{:});
catch ME
    throw(ME);
end




% [EOF]
