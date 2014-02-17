function isincprops(c)
%ISINCPROPS Add the Inverse Sinc properties.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/06/06 17:17:51 $

p = schema.prop(c, 'FrequencyFactor', 'double');
set(p, 'FactoryValue', .5);

p = schema.prop(c, 'Power', 'double');
set(p, 'FactoryValue', 1);

p = schema.prop(c, 'CICRateChangeFactor', 'double');
set(p, 'FactoryValue', 1);

% [EOF]
