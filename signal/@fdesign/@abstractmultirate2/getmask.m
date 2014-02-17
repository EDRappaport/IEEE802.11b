function [F, A] = getmask(this, fcns, rcf, varargin)
%GETMASK   Get the mask.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2005/06/30 17:33:53 $

rcf  = getratechangefactors(this);

% Get the mask from the contained FDESIGN.
[F, A] = getmask(this.CurrentFDesign, fcns, max(rcf),varargin{:});

% [EOF]
