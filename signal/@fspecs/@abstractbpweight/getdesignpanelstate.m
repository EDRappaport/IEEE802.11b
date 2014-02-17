function s = getdesignpanelstate(this)
%GETDESIGNPANELSTATE Get the designpanelstate.

%   Copyright 2004-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:03 $

s = aswofs_getdesignpanelstate(this);

s.Components{1}.Tag    = 'fdadesignpanel.bpfreqpassstop';
s.Components{1}.Fstop1 = sprintf('%g', this.Fstop1);
s.Components{1}.Fpass1 = sprintf('%g', this.Fpass1);
s.Components{1}.Fpass2 = sprintf('%g', this.Fpass2);
s.Components{1}.Fstop2 = sprintf('%g', this.Fstop2);

% [EOF]
