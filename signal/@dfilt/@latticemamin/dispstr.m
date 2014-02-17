function s = dispstr(Hd, varargin)
%DISPSTR Display string of coefficients.
%   DISPSTR(Hd) returns a string that can be used to display the coefficients
%   of discrete-time filter Hd.
%
%   See also DFILT.   
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.3.4.5 $  $Date: 2011/10/31 06:33:23 $
  
s = char({[getString(message('signal:dfilt:dfilt:Lattice')) ':']
          dispstr(Hd.filterquantizer, Hd.privLattice(:), varargin{:})
         });

% [EOF]
