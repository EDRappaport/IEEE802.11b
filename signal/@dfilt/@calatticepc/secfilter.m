function [y,zf] = secfilter(Hd,x,zi)
%SECFILTER Filter this section.
%   [Y,Zf] = SECFILTER(Hd,X,ZI) filters this section.  This function is only
%   intended to be called from DFILT/FILTER.  The initial conditions have
%   already been padded for the C++ implementation.
%
%   See also DFILT.   
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.5.4.2 $  $Date: 2004/04/12 23:53:36 $
  
% At this point, we could call the filter methods of the two lattice filters
% individually and then sum them, but we already have an efficient
% implementation of this structure in C, so we will call that directly.

q = Hd.filterquantizer;
[y,zf] = latticecapcfilter(q,Hd,x,zi);
