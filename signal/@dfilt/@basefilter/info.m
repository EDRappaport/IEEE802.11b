function varargout = info(this, varargin)
%INFO Information about filter.
%   S = INFO(Hd) returns a string matrix with information about the filter.
%
%   See also DFILT.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.3.4.15 $  $Date: 2012/09/20 22:34:48 $

if nargin > 2
    error(message('signal:dfilt:basefilter:info:wrongnumArguments'));
end
if nargin == 2
    if ~iscellstr(varargin)
        error(message('signal:dfilt:basefilter:info:wrongtypeArguments'));
    else
        if ~(strcmpi(varargin{:},'short') ||  strcmpi(varargin{:}, 'long'))
            error(message('signal:dfilt:basefilter:info:wrongArgumentstring'));
        else
            format = varargin{:};
        end
    end
else % nargin == 1
    format = 'short'; % default
end
[p, v] = thisinfo(this);

if this.FromSysObjFlag
  % Do not show filter internals if the dfilt object has been generated
  % from a System object
  idx = find(strcmp(p,getString(message('signal:dfilt:info:Input'))));
  p(idx:end) = [];
  v(idx:end) = [];
end
  
infostrs = getTranslatedString('signal:dfilt:info',getinfoheader(this));

% If there is no extra information, just show the title.
if ~isempty(p)

    spacerindx = find(strcmp(p, 'spacer') & strcmp(v, 'spacer')); 

    p(spacerindx) = {' '};
    v(spacerindx) = {' '};
    infostrs = { ...
        infostrs, ...
        repmat('-', 1, size(infostrs, 2)), ...
        [char(p{:}) repmat('  : ', length(p), 1), char(v{:})], ...
        };

    % Remove the extra ':'
    infostrs{end}(spacerindx, :) = ' ';

    infostrs = char(infostrs{:});
end

if strcmpi(format, 'long')
    % Add the measurements to the information if they are present.
    if isfdtbxinstalled

        % Add the design method
        desmeth = this.privdesignmethod;
        fmeth = this.privfmethod;
        if ~isempty(desmeth) && ~isempty(fmeth) && isprop(fmeth,'FromFilterDesigner') && fmeth.FromFilterDesigner
          % If design comes from a filter designer object, format method
          % name.
          fdesigner = getfdesign(this);
          desmeth = fdesigner.DesignMethod;
        end
        
        if ~isempty(desmeth),
            desmethstr = [getString(message('signal:dfilt:info:DesignAlgorithm')), ' : ', desmeth];
            infostrs = strvcat(infostrs, ' ', ...
                getString(message('signal:dfilt:info:DesignMethodInformation')), desmethstr);
        end

        fmeth = this.privfmethod;
        if ~isempty(fmeth) && ~isempty(fmeth.tostring),
            infostrs = strvcat(infostrs, ' ', ...
                getString(message('signal:dfilt:info:DesignOptions')), fmeth.tostring);
        end

        % Add the design specs
        fdes = this.privfdesign;
        if ~isempty(fdes),
            infostrs = strvcat(infostrs, ' ', ...
                getString(message('signal:dfilt:info:DesignSpecifications')), fdes.tostring);
        end

        m = measure(this);
        if ~isempty(m)
            infostrs = strvcat(infostrs, ' ', ...
                getString(message('signal:dfilt:info:Measurements')), m.tostring);
        end

        % Add cost
        try
            % Cost will fail for certain structures like statespace
            c = cost(this);
            infostrs = strvcat(infostrs, ' ', getString(message('signal:dfilt:info:ImplementationCost')), c.tostring);
        catch %#ok<CTCH>
            % Do nothing
        end
    end
end

if nargout
    varargout = {infostrs};
else
    disp(infostrs);
end


% [EOF]
