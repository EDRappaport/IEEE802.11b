function [isvalid, errmsg, errid] = checkincfreqs(h,fprops)
%CHECKINCFREQS   Check for increasing frequencies.
%
%   Inputs:
%       fprops - cell array of frequency properties expected in increasing
%       order.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.7 $  $Date: 2012/09/20 22:35:32 $


% If design comes from a filter designer object, convert fprops to valid
% designer object names.
if isprop(h,'FromFilterDesigner') && h.FromFilterDesigner
  propNames = signal.internal.filterdesigner.convertpropnames(fprops);
else
  propNames = fprops;
end

% Get all frequency specs
fspecs = get(h,fprops);

% Make it a vector
fspecs = [fspecs{:}];

isvalid = true;
errmsg  = '';
errid   = '';

% Check for increasing values
if any(diff(fspecs) <= 0),
    % Form string for error message
    specstr = '';
    for n = 1:length(fprops)-1,
        specstr = [specstr,propNames{n},', ']; %#ok<AGROW>
    end
    % Add last one
    specstr = [specstr,propNames{end}];
    
    isvalid = false;
    errmsg  = specstr;
    errid   = 'signal:fspecs:abstractspec:checkincfreqs:invalidSpec';
end

if nargout == 0 && ~isvalid
    error(message(errid,errmsg));
end