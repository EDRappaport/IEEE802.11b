function p = propstoadd(this)
%PROPSTOADD Return the properties to add to the parent object.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/06/06 17:17:43 $

p = propstoadd(this.CurrentSpecs);

p = {'Description', 'NumberOfSections', 'DifferentialDelay', ...
  'CICRateChangeFactor', p{:}}; %#ok<CCAT>

% [EOF]
