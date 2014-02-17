function freqs = get_peakfrequencies(this, freqs)
%GET_PEAKFREQUENCIES PreGet function for the 'PeakFrequencies'
%property

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2008/10/31 07:00:41 $

if isequal(lower(this.CombType),'peak')
    freqs = get(this.CurrentSpecs, 'PeakNotchFrequencies');
else
    freqs = ('N/A (notching comb)');
end

% [EOF]
