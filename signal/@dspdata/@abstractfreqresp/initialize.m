function this = initialize(this,varargin)
%INITIALIZE   Initialize power spectrum data objects.
%   INITIALIZE(H,DATA,FREQUENCIES) sets the H object with DATA as the data
%   and FREQUENCIES as the frequency vector.  If FREQUENCIES is not
%   specified it defaults to [0, pi).
%
%   INITIALIZE(...,p1,v1,p2,v2) See help for concrete classes.
%

%   Author(s): P. Pacheco
%   Copyright 1988-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.12 $  $Date: 2011/05/13 18:11:22 $

error(nargchk(1,13,nargin,'struct'));

% Set default values.
data = [];
dataLen = 0;
W = [];
opts = [];
hopts = createoptsobj(this);

if nargin > 1,
    data = varargin{1};
    [data, dataLen] = validate_data(this, data);

    % Parse the rest of the inputs if any.
    opts = varargin(2:end);
    [W,opts] = parseinputs(this,opts,dataLen,hopts); % Updates optiosn object.
end

% Verify that the cell array of options contains valid pv-pairs for dspdata.
propName = getrangepropname(this);  % Handle SpectrumRange and SpectrumType

if(strcmp(this.Name,'Power Spectral Density') || strcmp(this.Name,'Mean-Square Spectrum'))
    validProps = lower({propName,'CenterDC','Fs','ConfLevel','ConfInterval'}); 
    validateopts(this,opts,validProps);
    set(this,'ConfLevel',hopts.COnfLevel,...
    'ConfInterval', hopts.ConfInterval);
else
    validProps = lower({propName,'CenterDC','Fs'});    
    validateopts(this,opts,validProps);    
end

% Set the properties of the object. Use options obj settings for defaults.
set(this,...
    'Data',data,...
    'Frequencies', W,...
    'CenterDC',hopts.CenterDC,...
    'privNormalizedFrequency',hopts.NormalizedFrequency,...
    'Fs',hopts.Fs);

% Handle read-only property in subclass separately.
setspectrumtype(this,get(hopts,propName));

%--------------------------------------------------------------------------
function validateopts(this,opts,validProps)
% Verify that the cell array of options contain valid pv-pairs.

if isempty(opts); return; end

optsLen = ceil(length(opts)/2);  % account values.

for k = 1:optsLen,
    propName = opts{2*k-1}; % pick every odd element which should be the "Property"
    lc_propname = lower(propName);
    if ~ischar(lc_propname) || isempty(strmatch(lc_propname,validProps))
        error(message('signal:dspdata:abstractfreqresp:initialize:invalidStringInParameterValuePair', propName));
    end
end

%--------------------------------------------------------------------------
function [data,dataLen] = validate_data(this, data)
% Validate and get the size of the input data.

% Determine if the input is a matrix; and if row make it a column.
[data,dataLen] = checkinputsigdim(data);

validatedata(this, data);

%--------------------------------------------------------------------------
function  validate_freq(hopts,W)
%VALIDATE_FREQ  Return an error if an invalid frequency vector was specified.
% Valid ranges are:
%
%  0 to Fs       or  0 to 2pi
%  0 to Fs/2     or  0 to pi  
%  -Fs/2 to Fs/2 or  -pi to pi

sampFreq = hopts.Fs;
centerdc = hopts.CenterDC;
ishalfnyquistinterval = ishalfnyqinterval(hopts);

% Setup up end-points and define valid frequency ranges.
if hopts.NormalizedFrequency,
    unitStr = ' rad/sample';
    sampFreq = 2*pi;
    freqrangestr_start = '[0';
    freqrangestr_end = '2*pi)'; 

    if centerdc,
        freqrangestr_start = '(-pi';
        freqrangestr_end = 'pi]';
    elseif ishalfnyquistinterval,
        halfsampFreq = pi;
        freqrangestr_start = '[0';
        freqrangestr_end = 'pi)';
    end
    halfsampFreq = sampFreq/2;

else
    halfsampFreq = sampFreq/2;
    unitStr = ' Hz';
    freqrangestr_start = '[0';
    freqrangestr_end = sprintf('%s)',num2str(sampFreq)); 

    if centerdc,
        freqrangestr_start = sprintf('(-%s',num2str(halfsampFreq));
        freqrangestr_end = sprintf('%s]',num2str(halfsampFreq));
    elseif ishalfnyquistinterval,
        freqrangestr_start = '[0';
        freqrangestr_end = sprintf('%s)',num2str(halfsampFreq));
    end
end

% Validate the frequency vector.

if centerdc,
    % Not distiguishing between odd or even length of data.  This allows
    % non-uniformly sampled data.
    if  W(1) <= -halfsampFreq || W(end) > halfsampFreq,
        error(message('signal:dspdata:abstractfreqresp:initialize:invalidFrequencyVector', freqrangestr_start, freqrangestr_end, unitStr));
    end

elseif ishalfnyquistinterval,
    % Not distiguishing between odd or even length of data.  This allows
    % non-uniformly sampled data.
    if W(end) > halfsampFreq, 
        error(message('signal:dspdata:abstractfreqresp:initialize:invalidFrequencyVector', freqrangestr_start, freqrangestr_end, unitStr));
    end

else
    if W(end) >= sampFreq, 
        error(message('signal:dspdata:abstractfreqresp:initialize:invalidFrequencyVector', freqrangestr_start, freqrangestr_end, unitStr));
    end
end

%--------------------------------------------------------------------------
function [W,opts]= parseinputs(this,opts,dataLen,hopts)
% Parse the input.  Use the options object as a means to get default values
% for some of the dspdata object parameters.

% Define default values in case of early return due to an error.
W = [];      % Default frequency vector.

% Parse options.
if ~isempty(opts) && ~ischar(opts{1}),
    W = opts{1};     % Assume it's the frequency vector
    opts(1)=[];
    sizechkdatanfreq(this,dataLen,length(W));  
end

% Update the options object with dspdata options specified, if any, to pass
% it to the psdfreqvec and validate_freq functions below.
set(hopts,opts{:}); 
hopts.NFFT = dataLen; % Update NFFT based on the input data length.

if isempty(W),
    W = psdfreqvec(this,hopts);
else
    % No need to verify since we're creating the vector.
    validate_freq(hopts,W);
end

%--------------------------------------------------------------------------
function  sizechkdatanfreq(this,dataLen,lenW)
%SIZECHKDATANFREQ  Return an error msg if the sizes don't match.

% Verify that the data and frequency vector are the same length!
if dataLen ~= lenW,
    error(message('signal:dspdata:abstractfreqresp:initialize:sizemismatchDataFrequency'));
end

% [EOF]
