function logreport = getlogreport(this)
%GETLOGREPORT   Get the logreport.

%   Author(s): V. Pellissier
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $  $Date: 2011/05/13 18:09:10 $

logreport = this.filterquantizer.loggingreport;
if isempty(logreport),
    w = warning('on');
    warning(message('signal:dfilt:abstractfilter:getlogreport:LoggingOff', '''Arithmetic''', '''fixed'''));
    warning(w);
else
    logreport = copy(logreport);
end

% [EOF]
