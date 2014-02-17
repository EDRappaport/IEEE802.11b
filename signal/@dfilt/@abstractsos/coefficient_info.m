function [p, v] = coefficient_info(this)
%COEFFICIENT_INFO   

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/05/15 14:28:46 $

p = {getString(message('signal:dfilt:info:NumberofSections'))};
v = {sprintf('%d', nsections(this))};

% [EOF]
