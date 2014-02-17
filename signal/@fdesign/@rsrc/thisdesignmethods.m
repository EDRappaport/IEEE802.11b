function varargout = thisdesignmethods(this, varargin)
%THISDESIGNMETHODS   Return the valid design methods.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.8.2 $  $Date: 2006/11/19 21:45:11 $

% Return {} if the user requested IIR.
if any(strcmpi(varargin, 'iir'))
    varargout = {{}, false, 'iir'};
    return;
end

% Ask the contained object which FIR design methods are available.
[varargout{1:nargout}] = thisdesignmethods(this.CurrentFDesign, ...
    varargin{:}, 'fir');

% Filter out multistage
varargout{1} = setdiff(varargout{1},{'multistage', 'Multistage equiripple'})';

% [EOF]
