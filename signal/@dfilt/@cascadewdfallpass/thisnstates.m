function n = thisnstates(this)
%THISNSTATES   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:23:56 $

Hd = dispatch(this);

n = nstates(Hd);

% [EOF]
