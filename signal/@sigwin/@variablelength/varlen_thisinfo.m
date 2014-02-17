function [p, v] = varlen_thisinfo(h)
%VARLEN_THISINFO Information for variablelength class.

% This should be a private method.

%   Author(s): P. Costa
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2012/05/15 14:29:11 $

p = {getString(message('signal:dfilt:info:Length'))};
v = {sprintf('%g', get(h, 'length'))};

% [EOF]
