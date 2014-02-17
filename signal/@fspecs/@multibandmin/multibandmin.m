function this = multibandmin(varargin)
%MULTIBANDMIN Construct a MULTIBANDMIN object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/02/21 07:09:38 $

this = fspecs.multibandmin;

respstr = 'Multi-Band Arbitrary Magnitude';
fstart = 1;
fstop = 1;
nargsnoFs = 2;
fsconstructor(this,respstr,fstart,fstop,nargsnoFs,varargin{:});

% [EOF]
