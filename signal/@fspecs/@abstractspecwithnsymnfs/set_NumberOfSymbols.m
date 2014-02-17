function numSymbols = set_NumberOfSymbols(this, numSymbols)
%SET_FILTERLENGTH PreSet function for the 'NumberOfSymbols' property

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2010/12/06 00:11:07 $

if mod(numSymbols*this.SamplesPerSymbol, 2)
    error(message('signal:fspecs:abstractspecwithnsymnfs:set_NumberOfSymbols:InvalidNumberOfSymbols'));
end

% [EOF]
