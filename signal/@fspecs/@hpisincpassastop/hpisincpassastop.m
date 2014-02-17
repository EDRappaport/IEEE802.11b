function this = hpisincpassastop(varargin)
%HPISINCPASSASTOP Construct a HPISINCPASSASTOP object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:57:36 $

this = fspecs.hpisincpassastop;

fsconstructor(this,'Inverse-sinc highpass',2,2,6,varargin{:});

% [EOF]
