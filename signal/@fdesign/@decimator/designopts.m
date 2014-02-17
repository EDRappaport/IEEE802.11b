function d = designopts(this, varargin)
%DESIGNOPTS   

%   Author(s): R. Losada
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2013/04/29 20:55:01 $

d = designopts(this.CurrentFDesign, varargin{:});

if isfield(d,'FilterStructure'),
    % Replace structure with multirate structure
    switch d.FilterStructure,
        case {'firinterp','dffir'},
            d.FilterStructure = 'firdecim';
        case 'cascadeallpass',
            d.FilterStructure = 'iirdecim';
            if isfield(d, 'SystemObject')
                d = rmfield(d, 'SystemObject');
            end
    end
end




% [EOF]
