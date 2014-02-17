function this = bpweightconstrained(varargin)
%BPWEIGHTCONSTRAINED Construct a BPWEIGHTCONSTRAINED object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:28 $

this = fspecs.bpweightconstrained;

respstr = 'Bandpass';
fstart = 2;
fstop = 5;
nargsnoFs = 8;
fsconstructor(this,respstr,fstart,fstop,nargsnoFs,varargin{:});

% [EOF]
