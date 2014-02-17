function Hns = noiseshape(this,Hd,WL,args)
%NOISESHAPE Noise-shape the FIR filter Hd

% This should be a private method

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/04/21 04:35:33 $

Hns = noiseshape(this.CurrentFDesign,Hd,WL,args);

% [EOF]
