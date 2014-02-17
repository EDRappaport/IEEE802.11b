function [Hbest,mrfflag] = optimizecoeffwlfir(this,varargin) %#ok<STOUT,INUSD>
%OPTIMIZECOEFFWLFIR Optimize coefficient wordlength for FIR filters.
%   This should be a private method.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:06:09 $

error(message('signal:dfilt:fftfir:optimizecoeffwlfir:unsupportedFilterStructure'));

% [EOF]
