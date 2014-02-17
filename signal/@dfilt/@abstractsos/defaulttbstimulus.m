function stimcell = defaulttbstimulus(Hb)
%DEFAULTTBSTIMULUS returns a cell array of stimulus types.
%   DEFAULTTBSTIMULUS returns a cell array of stimulus types
%   based on the filter structure of filter object Hq.
%   Possible values are, 'impulse','step','ramp','chirp', and
%   'noise'
%
%   See also DFILT, GENERATETBSTIMULUS.

%   Copyright 2003 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2004/01/25 23:02:37 $ 

stimcell = {'step','ramp','chirp'};

% [EOF]

