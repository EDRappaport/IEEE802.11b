function Hd = dispatch(Hb)
%DISPATCH Returns the contained DFILT objects.

%   Author: V. Pellissier
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.2.4.3 $  $Date: 2010/12/06 00:04:41 $

error(message('signal:dfilt:basefilter:dispatch:NotSupported', class( Hb )))

% [EOF]
