function [out idx] = parse_mapcoeffstoports(~,varargin)
%PARSE_MAPCOEFFSTOPORTS 

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:09:49 $

out = 'off';
idx = find(strcmpi(varargin,'MapCoeffsToPorts'));
if isempty(idx) || strcmpi(varargin{idx+1},'off'),
   if ~isempty(find(strcmpi(varargin,'CoeffNames'), 1)),
       error(message('signal:dfilt:basefilter:parse_mapcoeffstoports:InvalidParameter', 'MapCoeffsToPorts', 'on', 'CoeffNames'));
   end
else
    out = varargin{idx+1}; 
    if strcmpi(out,'on'),
        idx2 = find(strcmpi(varargin,'Link2Obj'));
        if ~isempty(idx2) && strcmpi(varargin{idx2+1},'on')
            error(message('signal:dfilt:basefilter:parse_mapcoeffstoports:InvalidParameterPair', 'Link2Obj', 'MapCoeffsToPorts', 'on'));
        end
    end
end

% [EOF]
