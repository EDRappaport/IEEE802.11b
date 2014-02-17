function s = dispstr(Hd, varargin)
%DISPSTR Display string of coefficients.
%   DISPSTR(Hd) returns a string that can be used to display the coefficients
%   of discrete-time filter Hd.
%

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/10/31 06:32:52 $

s = char({getString(message('signal:dfilt:dfilt:Coefficients'))
    dispstr(Hd.filterquantizer, Hd.privcoeffs(:), varargin{:})});

% [EOF]
