function  Hd = iirlinphase(this,varargin)
%IIRLINPHASE   IIR quasi linear phase digital filter design.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:11:29 $

Hd = design(this, 'iirlinphase', varargin{:});
h = getfmethod(Hd);

if ishp(this),
    if isa(Hd,'mfilt.abstractmultirate'),
        error(message('signal:fspecs:hbord:iirlinphase:InvalidStructure'));
    end
    Hd = iirlp2hp(Hd,.5,.5);
    % Reset the contained FMETHOD.
    Hd.setfmethod(h);
end

