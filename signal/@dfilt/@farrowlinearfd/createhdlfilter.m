function hF = createhdlfilter(this)
%CREATEHDLFILTER Returns the corresponding hdlfiltercomp for HDL Code
%generation.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.4.2 $  $Date: 2007/09/18 02:30:43 $

hF = hdlfilter.farrowlinearfd;
this.sethdl_abstractfarrow(hF);

hF.TapSumSLType = conv2sltype(this.filterquantizer, 'TapSumWordlength', 'TapSumFraclength', true);

% [EOF]
