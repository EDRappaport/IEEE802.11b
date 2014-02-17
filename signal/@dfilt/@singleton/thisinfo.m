function [p, v] = thisinfo(this)
%THISINFO   

%   Author(s): J. Schickler
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2012/05/15 14:29:03 $

[p, v] = basefilter_info(this);

if isquantized(this)
    p{end+1} = getString(message('signal:dfilt:info:Arithmetic'));
    v{end+1} = get(this, 'Arithmetic');
        
    [f, c] = info(this.filterquantizer);

    if ~isempty(f)
        p = [p f(:)'];
        v = [v c(:)'];
    end
end

% [EOF]
