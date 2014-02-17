function Ht = firxform(Ho,fun,varargin)
%FIRXFORM FIR Transformations

%   Author(s): J. Schickler
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/05/13 18:11:09 $

error(message('signal:dfilt:singleton:firxform:FreqXfmNotSupported', get( Ho, 'FilterStructure' )));


% [EOF]
