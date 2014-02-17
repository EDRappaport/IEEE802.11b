function this = sbarbgrpdelay(varargin)
%SBARBGRPDELAY Construct a SBARBGRPDELAY object.

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/12/27 01:21:16 $

this = fspecs.sbarbgrpdelay;
% Default response
F1 = [0 0.1 1];
Gd = [2 3 1];

this.Frequencies = F1;
this.GroupDelay = Gd;

respstr = 'Single-Band Arbitrary Group Delay';
fstart = 1;
fstop = 1;
nargsnoFs = 4;
fsconstructor(this,respstr,fstart,fstop,nargsnoFs,varargin{:});
% [EOF]
