function warnsv(Hd)
%WARNSV Warn if too many scale values.
%   WARNSV Will send a warning is there are too many scale values.
%
%
%   See also DFILT.   
  
%   Author: R. Losada
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.2.4.1 $  $Date: 2011/05/13 18:09:26 $
  
nsecs = nsections(Hd);

if length(Hd.ScaleValues) > nsecs + 1,
    warning(message('signal:dfilt:abstractsos:warnsv:scalevalues', nsecs + 1));
end
