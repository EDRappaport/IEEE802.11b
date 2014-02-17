function [y,z] = secfilter(this,x,d,z)
%SECFILTER   

%   Author(s): V. Pellissier
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:55 $
C = this.privcoeffs;
C = C.';
[y,z] = farrowfdfilter(this.filterquantizer,C,x,d,z);

% [EOF]
