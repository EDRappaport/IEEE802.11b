function freqs = get_notchfrequencies(this, freqs)
%GET_NOTCHFREQUENCIES PreGet function for the 'NotchFrequencies'
%property

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2008/10/31 07:00:39 $

if isequal(lower(this.CombType),'notch')
    freqs = get(this.CurrentSpecs, 'PeakNotchFrequencies');
else
    freqs = ('N/A (peaking comb)');
end

% [EOF]
