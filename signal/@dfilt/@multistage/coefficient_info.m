function [p,v] = coefficient_info(this)
%COEFFICIENT_INFO   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/05/15 14:29:01 $

p = {getString(message('signal:dfilt:info:NumberofStages'))};
v = {num2str(nstages(this))};

% [EOF]
