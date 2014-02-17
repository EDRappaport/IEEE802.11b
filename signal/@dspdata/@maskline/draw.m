function varargout = draw(this, hax)
%DRAW   Draw the mask lines.

%   Author(s): J. Schickler
%   Copyright 2004 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/09/28 03:41:56 $

% We can only plot a validated object.
validate(this);

if nargin < 2
    hax = newplot;
end

h = line(this.FrequencyVector, this.MagnitudeVector, ...
    'Parent', hax, ...
    'Color',  'r', ...
    'LineStyle', '--',...
    'Tag',    'maskline');

if nargout
    varargout = {h};
end

% [EOF]
