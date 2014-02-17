function validatedata(this, data)
%VALIDATEDATA   Validate the data for the calling class.

%   Author(s): J. Schickler
%   Copyright 1988-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2011/05/13 18:11:15 $

% If the data is passed, use it, otherwise validate what is in the object.
if nargin < 2
    data = get(this, 'Data');
end

% Check that the data is real, positive, and not empty.
if any(~isreal(data(:))) |  any(data(:) < 0) | isempty(data),
    error(message('signal:dspdata:validatedata:invalidData', 'Data', 'Data'));
end


% [EOF]
