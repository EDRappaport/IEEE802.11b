function setfs(Hd, fs)
%SETFS Set the FS of the filter/filters

%   Author(s): J. Schickler
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.1.4.2 $  $Date: 2010/12/06 00:05:45 $

if ~iscell(fs),
    set(Hd, 'Fs', fs);
else
    if length(fs) ~= length(Hd),
        error(message('signal:dfilt:dfiltwfs:setfs:InvalidDimensions'));
    end
    
    for indx = 1:length(Hd),
        set(Hd(indx), 'Fs', fs{indx});
    end
end

send(Hd(1), 'NewFs', handle.EventData(Hd(1), 'NewFs'));

% [EOF]
