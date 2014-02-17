function varargout = multistage(this, varargin)
%MULTISTAGE   Design a multistage equiripple interpolator.

%   Author(s): J. Schickler
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $  $Date: 2011/05/13 18:12:43 $

% Make sure that MULTISTAGE is valid for this set of specifications.
if ~isdesignmethod(this, 'multistage')
    error(message('signal:fdesign:interpolator:multistage:invalidMethod', 'MULTISTAGE', this.Specification));
end

% Parse the inputs for the multirate filter structure.
[filtstruct, varargin] = parsestruct(this, 'firinterp', 'multistage', varargin{:});

ifactor = get(this, 'InterpolationFactor');

Hm = multistage(this.CurrentFDesign, varargin{:}, 'rcf', ifactor,...
    'FilterStructure',filtstruct);

% Use THIS object instead of the 'CurrentFDesign'.
Hm.setfdesign(this);

if nargout
    varargout = {Hm};
else
    if this.NormalizedFrequency,
        inputs = {'NormalizedFrequency', 'On'};
    else
        inputs = {'Fs', this.Fs};
    end

    fvtool(Hm, inputs{:});
end

% [EOF]
