function b = isdesignmethod(this, varargin)
%ISDESIGNMETHOD   True if the object is designmethod.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:21:12 $

b = isdesignmethod(this.CurrentFDesign, varargin{:});

% [EOF]
