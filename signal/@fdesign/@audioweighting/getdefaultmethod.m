function defaultmethod = getdefaultmethod(this)
%GETDEFAULTMETHOD   Get the defaultmethod.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:09 $

switch lower(this.Specification)
    case {'wt'}
        defaultmethod = 'freqsamp';
    case {'wt,class'}
        defaultmethod = 'ansis142';
    otherwise,
        error(message('signal:fdesign:audioweighting:getdefaultmethod:InternalError'));
end


% [EOF]
