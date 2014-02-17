function this = sbarbmagmin(varargin)
%SBARBMAGMIN Construct a SBARBMAGMIN object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/02/21 07:09:45 $

this = fspecs.sbarbmagmin;

respstr = 'Single-Band Arbitrary Magnitude';
fstart = 1;
fstop = 1;
nargsnoFs = 3;
fsconstructor(this,respstr,fstart,fstop,nargsnoFs,varargin{:});
% [EOF]
