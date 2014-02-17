function hF = createhdlfilter(this)
%CREATEHDLFILTER Returns the corresponding hdlfiltercomp for HDL Code
%generation.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2010/12/06 00:04:40 $

error(message('signal:dfilt:basefilter:createhdlfilter:NotHdlable', class( this )));
                   

% [EOF]
