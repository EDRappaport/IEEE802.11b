function S = thissetstates(Hd,S)
%THISSETSTATES Overloaded set for the States property.

% This should be a private method

%   Author: R. Losada
%   Copyright 1988-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:34 $

% Check data type, quantize if needed
S = validatestates(Hd.filterquantizer, S);

Hd.HiddenStates = S;
S = [];
