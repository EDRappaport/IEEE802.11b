function this = hpisinccutoffwatten(varargin)
%HPISINCCUTOFFWATTEN Construct a HPISINCCUTOFFWATTEN object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:57:22 $

this = fspecs.hpisinccutoffwatten;

fstart = 2;
fstop = 2;
nargsnoFs = 6;
fsconstructor(this,'Inverse-sinc highpass',fstart,fstop,nargsnoFs,varargin{:});

% [EOF]
