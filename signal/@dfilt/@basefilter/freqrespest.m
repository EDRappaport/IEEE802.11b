function varargout = freqrespest(this,L,varargin)
%FREQRESPEST   Frequency response estimate via filtering.
%   [H,W] = FREQRESPEST(Hd,L) computes the frequency response estimate of
%   the filter Hd by running input data made up from sinusoids
%   with uniformily distributed random frequencies through the filter and
%   forming the ratio between output data and input data. This is
%   particularly useful for fixed-point filters, a frequency response
%   estimate that is close to the frequency response obtained by using only
%   the quantized coefficients but ignoring the fixed-point
%   additions/multiplications is a good indication that the filter's
%   fixed-point performance closely matches a floating point implementation
%   with the same (quantized) coefficients.
%
%   L is the number of trials used to compute the estimate. If not
%   specified, L defaults to 10. In general, the more trials used, the more
%   accurate estimate obtained at the expense of a longer time needed to
%   compute the estimate.
%
%   H is the estimate of the complex frequency response. W is a vector of
%   frequencies at which H is estimated.
%
%   [H,W] = FREQRESPEST(Hd,L,P1,V1,P2,V2,...) specifies optional parameters
%   via parameter-value pairs. Valid pairs are:
%         Parameter           Default        Description/Valid values
%    ---------------------  -----------  ----------------------------------
%    'NFFT'                 512          Number of FFT points.
%    'NormalizedFrequency'  true         {true,false}
%    'Fs'                   'Normalized' Sampling frequency. Only used when
%                                        'NormalizedFrequency' is false.
%    'SpectrumRange'        'Half'       {'Half','Whole'}
%    'CenterDC'             false        {true,false} 
%
%   FREQRESPEST(Hd,L,OPTS) uses an options object to specify the optional
%   parameters in lieu of specifying parameter-value pairs. The OPTS object
%   can be created with OPTS = FREQRESPOPTS(Hd). Settings can be changed
%   in OPTS before calling FREQRESPEST, e.g. set(OPTS,'Fs',48e3);
%
%   Another use of FREQRESPEST is to compute the frequency response of
%   double-precision floating filters that cannot be converted to transfer
%   function form without introducing significant round-off errors that
%   would affect the computation via FREQZ. Examples can be some
%   state-space or lattice filters, in particular large order filters.
%
%   % Example 1. Compute the frequency response estimate of a fixed-point
%   % FIR filter with filter internals set to full precision. Because full
%   % precision introduces no extra round-off, the estimate is
%   % approximately the same as computing FREQZ.
%   Hd = design(fdesign.lowpass(.4,.5,1,60),'equiripple');
%   Hd.Arithmetic = 'fixed';
%   [H,w] = freqrespest(Hd); % This should be about the same as FREQZ
%
%   % Example 2. Compute the frequency response estimate for the same
%   % fixed-point FIR filter as in Example 1, but specify the precision of
%   % additions/multiplications so that round-off error is introduced.
%   Hd.FilterInternals = 'SpecifyPrecision';
%   Hd.OutputWordLength=16; Hd.OutputFracLength=15;
%   Hd.ProductWordLength=16; Hd.ProductFracLength=15;
%   Hd.AccumWordLength=16; Hd.AccumFracLength=15;
%   [H,w] = freqrespest(Hd,2);
%   [H2,w2] = freqz(Hd,512);
%   plot(w/pi,20*log10(abs([H,H2])))
%   legend('Frequency response estimate by filtering',...
%       'Frequency response computed by quantizing coefficients only');
%   xlabel('Normalized Frequency (\times\pi rad/sample)')
%   ylabel('Magnitude (dB)')
%
%   % Example 3. Estimate the frequency response of a state-space filter.
%   Fs = 315000;
%   Wp = [320 3800]/(Fs/2);
%   Ws = [50 19000]/(Fs/2);
%   Rp=0.15; Rs=60;
%   [n,Wn]=cheb1ord(Wp,Ws,Rp,Rs);
%   [a,b,c,d] = cheby1(n,Rp,Wn);
%   Hd = dfilt.statespace(a,b,c,d);
%   freqrespest(Hd,1,'NFFT',8192); % Compare to freqz(Hd,8192);
%
%   See also dfilt/freqrespopts, dfilt/noisepsd,  dfilt/scale, 
%   dfilt/functions.

%   Author(s): R. Losada
%   Copyright 1988-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2007/12/14 15:07:27 $

if nargin < 2,
    if isempty(findprop(this,'Arithmetic')) || ...
            any(strcmpi(this.Arithmetic,{'double','single'})),
        L = 1;
    elseif strcmpi(this.Arithmetic,'fixed') && ...
            ~isempty(findprop(this,'FilterInternals')) && ...
            strcmpi(this.FilterInternals,'FullPrecision')
        L = 1;
    else
        L = 10;
    end
end

if nargout,
    [h,w] = compute_freqrespest(this, L, varargin{:});
    varargout = {h, w};
else
    opts = uddpvparse('dspopts.freqresp', {'freqrespopts', this}, varargin{:});
    fvtoolopts = spectrumopts2fvtool(this,opts);
    fvtool(this, 'Analysis','magestimate', 'NumberofTrials',L,fvtoolopts{:});
end

% [EOF]
