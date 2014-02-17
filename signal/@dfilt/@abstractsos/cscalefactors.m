function c = cscalefactors(h,opts)
%CSCALEFACTORS   Cumulative scale factors

%   Author(s): R. Losada
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2004/04/12 23:52:10 $

nb = nsections(h);

c = zeros(1,nb+1);

c = lclcscalefactors(h,c,nb,opts);

% [EOF]
