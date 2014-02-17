function [isvalid, errmsg, errid] = thisvalidate(h)
%THISVALIDATE   

%   Copyright 2003-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:06 $

[isvalid, errmsg, errid] = checkincfreqs(h,{'Fstop1','Fpass1','Fpass2','Fstop2'});

% [EOF]
