function Hd = dispatch(this)
%DISPATCH   Returns the LWDFILT.

%   Author(s): J. Schickler
%   Copyright 2004 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/02/23 02:48:00 $

[b, a] = cl2tf(this.Allpass1, this.Allpass2, this.Beta);

Hd = lwdfilt.tf(b, a);

[b, a] = cl2tf(this.refAllpass1, this.refAllpass2, this.refBeta);

set(Hd, 'refnum', b, ...
    'refden', a);

% [EOF]
