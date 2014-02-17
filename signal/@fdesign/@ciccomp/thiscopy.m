function thiscopy(this, hOldObject)
%THISCOPY Copy properties specific to the fdesign.ciccomp class.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.8.2 $  $Date: 2011/06/06 17:17:47 $

set(this, 'DifferentialDelay', hOldObject.DifferentialDelay, ...
    'NumberOfSections', hOldObject.NumberOfSections,...
    'CICRateChangeFactor', hOldObject.CICRateChangeFactor );

% [EOF]
