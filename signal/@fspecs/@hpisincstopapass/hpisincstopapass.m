function this = hpisincstopapass(varargin)
%HPISINCSTOPAPASS Construct a HPISINCSTOPAPASS object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:57:42 $

this = fspecs.hpisincstopapass;

fsconstructor(this,'Inverse-sinc highpass',2,2,6,varargin{:});

% [EOF]
