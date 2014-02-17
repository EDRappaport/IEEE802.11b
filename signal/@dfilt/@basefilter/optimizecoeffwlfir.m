function [Hbest,mrfflag] = optimizecoeffwlfir(this,varargin) %#ok<STOUT>
%OPTIMIZECOEFFWLFIR Optimize coefficient wordlength for FIR filters.
%   This should be a private method.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/05/13 18:09:47 $

error(message('signal:dfilt:basefilter:optimizecoeffwlfir:unsupportedFilterStructure', class( this )));

% [EOF]
