function varargout = coupledallpass(varargin)
%COUPLEDALLPASS Coupled-allpass filter virtual class.
%   COUPLEDALLPASS is a virtual class---it is never intended to be instantiated.
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.4.4.5 $  $Date: 2011/05/13 18:10:03 $

error(message('signal:dfilt:coupledallpass:coupledallpass:SigErr', 'COUPLEDALLPASS'));
