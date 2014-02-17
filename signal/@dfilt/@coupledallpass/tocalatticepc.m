function Hd = tocalatticepc(this)
%TOCALATTICEPC   Convert to the pc calattice.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2004/10/18 21:01:23 $

Hd = dfilt.calatticepc(this.Allpass1, this.Allpass2, this.Beta);

% [EOF]
