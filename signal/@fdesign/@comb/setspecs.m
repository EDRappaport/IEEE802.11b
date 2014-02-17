function setspecs(this,combtype,varargin)
%SETSPECS Set the specs

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/05/13 18:12:27 $

if nargin < 2
    return;
end

%set combtype in fdesign
if isequal('notch', lower(combtype))
    set(this, 'CombType', 'Notch');
elseif isequal('peak', lower(combtype))
    set(this, 'CombType', 'Peak');
else
    error(message('signal:fdesign:comb:setspecs:InvalidCombType'));
end

%Send the combtype as another argument in varargin so that it is set in
%fspecs
varargin{end+1} = combtype;
this_setspecs(this, varargin{:});

% [EOF]
