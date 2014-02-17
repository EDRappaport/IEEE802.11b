function [Ht, anum, aden] = iirxform(Ho,fun,varargin)
%IIRXFORM IIR Transformations

%   Author(s): J. Schickler
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/05/13 18:11:10 $

% This should be private
error(message('signal:dfilt:singleton:iirxform:FreqXfmNotSupported', get( Ho, 'FilterStructure' )));


% [EOF]
