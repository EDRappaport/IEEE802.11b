function varargout = singleton(varargin)
%SINGLETON Singleton filter virtual class.
%   SINGLETON is a virtual class---it is never intended to be instantiated.
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.3.4.5 $  $Date: 2011/05/13 18:11:11 $

error(message('signal:dfilt:singleton:singleton:SigErr', 'SINGLETON')); 
