function [isvalid, errmsg, errid] = thisvalidate(h)
%THISVALIDATE Check that this object is valid.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:57:34 $

[isvalid, errmsg, errid] = checkincfreqs(h,{'Fstop','Fpass'});

% [EOF]
