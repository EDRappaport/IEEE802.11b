function varargout = thissfcnparams(Hd)
%THISSFCNPARAMS Returns the parameters for SDSPFILTER

% Author(s): J. Schickler
% Copyright 1988-2010 The MathWorks, Inc.
% $Revision: 1.1.6.4 $ $Date: 2010/12/06 00:06:44 $

error(message('signal:dfilt:notSupported', Hd.FilterStructure));

% [EOF]
