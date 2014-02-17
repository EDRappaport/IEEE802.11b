function s = iir_blockparams(Hd,forceDigitalFilterBlock)
%IIR_BLOCKPARAMS   Get the IIR-specific block parameters.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $  $Date: 2012/10/29 19:33:02 $

if nargin == 1
  forceDigitalFilterBlock = false;
end

s = blockparams(Hd.filterquantizer,forceDigitalFilterBlock);

refHd = reffilter(Hd);

if ~forceDigitalFilterBlock
  
  s.Numerator = mat2str(refHd.Numerator,18);
  s.Denominator = mat2str(refHd.Denominator,18);
  
else
  
  s.TypePopup = 'IIR (poles & zeros)';
  
  s.NumCoeffs = mat2str(refHd.Numerator,18);
  s.DenCoeffs = mat2str(refHd.Denominator,18);
  
end

