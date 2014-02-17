function cost(this)
%COST Cost Estimate.  
%   C = COST(Hd) return a cost estimate C for the filter Hd. The cost
%   estimate contains the following fields:
%     NMULT              : Number of multipliers* 
%                         (* excluding multiplications by 0,1,-1)
%     NADD               : Number of adders
%     NSTATES            : Number of states
%     MULTPERINPUTSAMPLE : Number of multiplications per input sample
%     ADDPERINPUTSAMPLE  : Number of additions per input sample
% 
%   EXAMPLE:
%   Hd = design(fdesign.lowpass);
%   c = cost(Hd)

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/08/20 13:25:50 $



% [EOF]
