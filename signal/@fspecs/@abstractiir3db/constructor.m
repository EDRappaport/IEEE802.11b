function constructor(h,varargin)
%CONSTRUCTOR   

%   Copyright 2008-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:18 $

respstr = h.ResponseType;
fstart = 3;
fstop = 3;
nargsnoFs = 3;
fsconstructor(h,respstr,fstart,fstop,nargsnoFs,varargin{:});

% [EOF]
