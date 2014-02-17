function Hs = tosysobj(this,returnSysObj)
%TOSYSOBJ Convert to a System object

%   Copyright 2013 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2013/04/29 20:54:56 $

if ~returnSysObj
  % If returnSysObj is false, then it means that we want to know if the
  % System object conversion is supported for the class at hand. Return a
  % flag as an output instead of throwing an error.
  Hs = true;
  return;
end  

Hs = dsp.CoupledAllpassFilter('Lattice');

Hs.LatticeCoefficients1 = {this.Allpass1};
Hs.LatticeCoefficients2 = {this.Allpass2};
Hs.Beta = this.Beta;

if this.PersistentMemory  
    IC = getinitialconditions(this);
    % Check if internal states are nontrivial
    if ~isempty(IC) && ~all(all(IC == 0))
        % The conversion to System object ignores
        % non-zero internal states as dsp.CoupledAllpassFilter does not
        % support non-zero initial conditions
        warning(message('signal:dfilt:calattice:tosysobj:nostatesupport'))
    end
end