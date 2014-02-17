function [p, v] = coefficient_info(this)
%COEFFICIENT_INFO   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/05/15 14:28:39 $

p = {getString(message('signal:dfilt:info:NumberofMultipliers'))};
v = {sprintf('%d', length(this.AllpassCoefficients))};

% [EOF]

