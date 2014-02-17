function setspecs(this, varargin)
%SETSPECS   Set the specifications

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:13:34 $

if nargin>1
    %combtype was prevously added in fdesign as the last argument of
    %varargin. Set CombType and delete it before setting the rest of the
    %specs
    this.CombType = varargin{end};
    varargin(end) = [];
    if ~isempty(varargin)
        if varargin{1} < 2
            error(message('signal:fspecs:combq:setspecs:invalidFilterOrderForNQSpecs'));
        end
    end    
end
aswfs_setspecs(this,varargin{:});

% [EOF]
