function varargout = thisdesignmethods(this, varargin)
%THISDESIGNMETHODS   Return the valid design methods.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2005/11/18 14:24:58 $

[varargout{1:nargout}] = ...
    currentfdesigndesignmethods(this.CurrentFDesign, ...
        varargin{:});
    


% [EOF]
