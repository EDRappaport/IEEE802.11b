function Hd = design(h,d)
%DESIGN  Method to design the filter given the specs.

%   Author(s): R. Losada
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.3.4.2 $  $Date: 2010/12/06 00:09:55 $


% Set up design params
N = get(d,'order');

% Get passband frequency, it has been prenormalized
Fpass = get(d,'Fpass');

if Fpass <= 0.5,
    error(message('signal:filtdes:remezhphalf:design:InvalidRange'));
end

b = firhalfband(N,1-Fpass,'high');

% Construct object
Hd = dfilt.dffir(b);



