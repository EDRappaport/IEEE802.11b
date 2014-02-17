function [p, v] = coefficient_info(this)
%COEFFICIENT_INFO   Get the coefficient information for this filter.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/05/15 14:29:04 $

p = {getString(message('signal:dfilt:info:FilterLength'))};
v = {sprintf('%d', order(this)+1)};

% [EOF]
