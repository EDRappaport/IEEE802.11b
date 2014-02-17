function minfo = measureinfo(this)
%MEASUREINFO   

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/10/16 06:41:27 $

minfo.Fs = this.CurrentSpecs.ActualDesignFs;

% Use non-interpolated masks to return measured attenuations at the frequencies
% specified by each standard. Return row vector so that it displays correctly
% on info.
minfo.F = this.CurrentSpecs.Fmask.'; 
minfo.A = this.CurrentSpecs.Amask.'; 

% Use interpolated masks to measure if specs are met
minfo.Finterp = this.CurrentSpecs.FmaskInterp.'; 
minfo.Ainterp = this.CurrentSpecs.AmaskInterp.'; 



% [EOF]
