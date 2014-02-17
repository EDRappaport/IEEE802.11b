function  validatenoverlap(this, NOverlap,N)
%VALIDATENOVERLAP Validate the noverlap

%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/05/13 18:13:55 $

if NOverlap>N-1,
    error(message('signal:spectrum:welch:validatenoverlap:InvalidOverlapPercent', num2str( 100*(N - 1)/N ), N));
end

% [EOF]
