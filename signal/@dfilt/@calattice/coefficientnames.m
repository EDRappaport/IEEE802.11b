function c = coefficientnames(Hd)
%COEFFICIENTNAMES  Coefficient names.
%   COEFFICIENTNAMES(Hd) returns a cell array of the names of the
%   coefficients for this filter structure.
%
%   EXAMPLE:
%           Hd = dfilt.calattice;
%           c = coefficientnames(Hd)
%
%   See also DFILT.   
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2008 The MathWorks, Inc.
%   $Revision: 1.3.4.3 $  $Date: 2008/09/13 07:14:31 $
  
% The singleton filters have extra no-op input parameters so you
% don't have to distinguish the calling syntax between singleton and
% multisection filters for this function.

c = {'Allpass1', 'Allpass2', 'Beta'};