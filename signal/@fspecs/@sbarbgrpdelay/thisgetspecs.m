function specs = thisgetspecs(this)
%THISGETSPECS Get the specs.

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/12/27 01:21:19 $

specs.Frequencies = this.Frequencies;
specs.GroupDelay = this.GroupDelay;
% Nominal group delay
specs.NomGrpDelay = this.NomGrpDelay; % this value is computed at design time

% [EOF]
