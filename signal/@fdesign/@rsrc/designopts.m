function d = designopts(this, varargin)
%DESIGNOPTS   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/12/22 19:01:04 $

d = designopts(this.CurrentFDesign, varargin{:});

% Replace structure with multirate structure
switch d.FilterStructure,
    case 'dffir',
        d.FilterStructure = 'firsrc';
end


% [EOF]
