function [p, v] = thisinfo(h)
%THISINFO Information for this class.

% This should be a private method.

%   Author(s): P. Costa
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2012/05/15 14:29:10 $

p = {getString(message('signal:dfilt:info:MATLABExpression'))};
v = {get(h, 'MATLAB_expression')};

% [EOF]
