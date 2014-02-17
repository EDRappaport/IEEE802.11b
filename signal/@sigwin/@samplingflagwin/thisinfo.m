function [p, v] = thisinfo(h)
%THISINFO Information for this class.

% This should be a private method.

%   Author(s): P. Costa
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2012/05/15 14:29:09 $

[pvl, vvl] = varlen_thisinfo(h);
p = {pvl{:}, getString(message('signal:dfilt:info:SamplingFlag'))};
v = {vvl{:},get(h, 'SamplingFlag')};


% [EOF]
