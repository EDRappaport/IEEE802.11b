function y = db2pow(ydB)
%DB2POW   dB to Power conversion
%   Y = DB2POW(YDB) converts dB to its corresponding power value such that
%   10*log10(Y)=YDB
%
%   % Example:
%   %   Convert 12dB to Power.
%
%   y = db2pow(12)      
%

%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.10.3 $  $Date: 2012/10/29 19:30:56 $

%#codegen 

y = 10.^(ydB/10);

% [EOF]
