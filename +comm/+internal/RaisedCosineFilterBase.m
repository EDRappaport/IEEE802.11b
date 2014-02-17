classdef RaisedCosineFilterBase < matlab.System
%RaisedCosineFilter Base class for raised cosine filters

%   Copyright 2012-2013 The MathWorks, Inc.

%#codegen

properties (Nontunable)
  %Shape   Filter shape
  %   Specify the filter shape as one of 'Normal' or 'Square root'. The
  %   default is 'Square root'.
  Shape = 'Square root'
  %RolloffFactor Rolloff factor
  %   Specify the rolloff factor as a scalar between 0 and 1. The default
  %   is 0.2.
  RolloffFactor = 0.2
  %FilterSpanInSymbols Filter span in symbols
  %   Specify the number of symbols the filter spans as an integer valued
  %   positive scalar. The default is 10. Since the ideal raised cosine
  %   filter has an infinite impulse response, the object truncates the
  %   impulse response to FilterSpanInSymbols symbols.
  FilterSpanInSymbols = 10
  %Gain    Linear filter gain
  %   Specify the linear gain of the filter as a positive numeric scalar.
  %   The default is 1. The object designs a raised cosine filter that has
  %   unit energy and then applies the linear gain to obtain final tap
  %   values.
  Gain = 1
end

properties (Access = protected, Nontunable)
  pFilter
end

properties (Constant, Hidden)
  ShapeSet = matlab.system.StringSet({...
    'Normal',...
    'Square root'});
end

methods (Abstract, Access = protected)
  getSamplesPerSymbol(obj)
end

methods
  function obj = RaisedCosineFilterBase(varargin)
    setProperties(obj, nargin, varargin{:});
  end

  function h = fvtool(obj, varargin)
    %fvtool Filter Visualization Tool (FVTool)
    %   FVTool is a Graphical User Interface (GUI) that allows you to
    %   analyze digital filters.

    prepareFilter(obj)
    h = fvtool(obj.pFilter, varargin{:});
  end

  function set.RolloffFactor(obj, aVal)
    validateattributes(aVal, {'numeric'}, ...
      {'scalar', 'real', 'nonnegative', '<=', 1}, ...
      '', 'RolloffFactor'); %#ok<EMCA>
    obj.RolloffFactor = aVal;
  end

  function set.FilterSpanInSymbols(obj, aVal)
    validateattributes(aVal, {'numeric'}, ...
      {'scalar', 'real', 'positive', 'finite', 'integer'}, ...
      '', 'FilterSpanInSymbols'); %#ok<EMCA>
    obj.FilterSpanInSymbols = aVal;
  end

  function set.Gain(obj, aVal)
    validateattributes(aVal, {'numeric'}, ...
      {'scalar', 'real', 'positive', 'finite', 'nonnan'}, ...
      '', 'Gain'); %#ok<EMCA>
    obj.Gain = aVal;
  end

  % Filter analysis methods
  function [Hr, W] = freqz(obj,varargin)
    %FREQZ  Frequency response of discrete-time filter System object
    %   [Hr,W] = freqz(H,N) returns the N-point complex frequency response
    %   vector Hr and the N-point frequency vector W in radians/sample of
    %   the filter System object H. The frequency response is evaluated at
    %   N points equally spaced around the upper half of the unit circle.
    %   If N is not specified, it defaults to 8192.
    %
    %   [Hr,W] = freqz(H,'Arithmetic',ARITH,...) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double', 'single', or 'fixed'. The
    %   analysis tool assumes a double precision filter when the arithmetic
    %   input is not specified and the filter System object is in an
    %   unlocked state.
    %
    %   freqz(H) with no output argument launches FVTool and shows the
    %   magnitude and phase responses of the filter System object, H.
    %
    %   For additional parameters, see signal/freqz.

    prepareFilter(obj)
    [Hr, W] = freqz(obj.pFilter, varargin{:});
  end
  %----------------------------------------------------------------------
  function [Phi, W] = phasez(obj,varargin)
    %PHASEZ Phase response of discrete-time filter (unwrapped)
    %   [Phi,W] = phasez(H,N) returns vectors Phi and W containing the
    %   phase response of the filter System object, H, and the frequencies
    %   (in radians) at which it is evaluated. The phase response is
    %   evaluated at N points equally spaced around the upper half of the
    %   unit circle. If you do not specify N, it defaults to 8192.
    %
    %   [Phi,W] = phasez(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.
    %
    %   phasez(H) with no output argument launches FVTool and shows the
    %   phase response of the filter System object, H.
    %
    %   For additional parameters, see signal/phasez.

    prepareFilter(obj)
    [Phi, W] = phasez(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function [Hr, W] = zerophase(obj,varargin)
    %ZEROPHASE Zero-phase response of discrete-time filter System object
    %   [Hr,W] = zerophase(H,N) returns length N vectors Hr and W
    %   containing the zero-phase response of the filter System object H,
    %   and the frequencies (in radians) at which it is evaluated. The
    %   zero-phase response is evaluated at N points equally spaced around
    %   the upper half of the unit circle. For an FIR filter where N is a
    %   power of two, the computation is done faster using FFTs. If you
    %   don't specify N, it defaults to 8192.
    %
    %   [Hr,W] = zerophase(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.
    %
    %   zerophase(H) with no output argument launches FVTool and shows the
    %   zero-phase response of the filter System object, H.
    %
    %   For additional parameters, see signal/zerophase.

    prepareFilter(obj)
    [Hr, W] = zerophase(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function [Gd, W] = grpdelay(obj,varargin)
    %GRPDELAY Group delay response of discrete-time filter System object
    %   [Gd,W] = grpdelay(H,N) returns length N vectors Gd and W containing
    %   the group delay of the filter System object, H, and the frequencies
    %   (in radians) at which it is evaluated. The group delay is defined
    %   as -d{angle(w)}/dw. The frequency response is evaluated at N points
    %   equally spaced around the upper half of the unit circle. For an FIR
    %   filter where N is a power of two, the computation is done faster
    %   using FFTs. If you do not specify N, it defaults to 8192.
    %
    %   [Gd,W] = grpdelay(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.
    %
    %   grpdelay(H) with no output argument launches FVTool and shows the
    %   group delay response of the filter System object, H.
    %
    %   For additional parameters, see signal/grpdelay.

    prepareFilter(obj)
    [Gd, W] = grpdelay(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function [Phi, W] = phasedelay(obj,varargin)
    %PHASEDELAY Phase delay response of discrete-time filter System object
    %   [PHI,W] = phasedelay(H,N) returns the N-point phase delay response
    %   vector PHI and the N-point frequency vector W in radians/sample of
    %   the filter System object, H. The phase response is evaluated at N
    %   points equally spaced around the upper half of the unit circle. If
    %   N is not specified, it defaults to 8192.
    %
    %   [Phi,W] = phasedelay(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.
    %
    %   phasedelay(H) with no output argument launches FVTool and shows the
    %   phase delay response of the filter System object, H.
    %
    %   For additional parameters, see signal/phasedelay.

    prepareFilter(obj)
    [Phi, W] = phasedelay(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function [Hr, T] = impz(obj,varargin)
    %IMPZ   Impulse response of discrete-time filter System object
    %   [Hr,T] = impz(H) computes the impulse response of the filter System
    %   object, H, and returns the response in column vector Hr, and a
    %   vector of times (or sample intervals) in T (T = [0 1 2...]'). The
    %   number of samples in the response is chosen automatically.
    %
    %   [Hr,T] = impz(H,'Arithmetic',ARITH,...) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double', 'single', or 'fixed'. The
    %   analysis tool assumes a double precision filter when the arithmetic
    %   input is not specified and the filter System object is in an
    %   unlocked state.
    %
    %   impz(H) with no output argument launches FVTool and shows the
    %   impulse response of the filter System object, H.
    %
    %   For additional parameters, see signal/impz.

    prepareFilter(obj)
    [Hr, T] = impz(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function L = impzlength(obj,varargin)
    %IMPZLENGTH Length of impulse response of discrete-time filter
    %   L = impzlength(H) returns the length, L, of the impulse response of
    %   the filter System object, H.
    %
    %   L = impzlength(H,TOL) specifies the tolerance, TOL, to increase or
    %   decrease the length accuracy. By default, TOL = 5e-5.
    %
    %   L = impzlength(H,'Arithmetic',ARITH,...) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double', 'single', or 'fixed'. The
    %   analysis tool assumes a double precision filter when the arithmetic
    %   input is not specified and the filter System object is in an
    %   unlocked state.

    prepareFilter(obj)
    L = impzlength(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function [Hr, T] = stepz(obj,varargin)
    %STEPZ Step response of discrete-time filter System object
    %   [Hr,T] = stepz(H) returns the step response Hr of the filter System
    %   object, H. The length of column vector H is computed using
    %   IMPZLENGTH. The vector of time samples at which H is evaluated is
    %   returned in vector T.
    %
    %   [Hr,T] = impz(H,'Arithmetic',ARITH,...) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double', 'single', or 'fixed'. The
    %   analysis tool assumes a double precision filter when the arithmetic
    %   input is not specified and the filter System object is in an
    %   unlocked state.
    %
    %   stepz(H) with no output argument launches FVTool and shows the step
    %   response of the filter System object, H.
    %
    %   For additional parameters, see signal/stepz.

    prepareFilter(obj)
    [Hr, T] = stepz(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function [HZ,HP,Hl] = zplane(obj,varargin)
    %ZPLANE Z-plane zero-pole plot for discrete-time filter System object
    %   zplane(H) plots the zeros and poles of the filter System object, H,
    %   with the unit circle for reference in the Filter Visualization Tool
    %   (FVTool). Each zero is represented with a 'o' and each pole with a
    %   'x' on the plot. Multiple zeros and poles are indicated by the
    %   multiplicity number shown to the upper right of the zero or pole.
    %
    %   zplane(H,'Arithmetic',ARITH,...) analyzes the filter System object,
    %   H, based on the arithmetic specified in the ARITH input. ARITH can
    %   be set to one of 'double', 'single', or 'fixed'. The analysis tool
    %   assumes a double precision filter when the arithmetic input is not
    %   specified and the filter System object is in an unlocked state.
    %
    %   [HZ,HP,Hl] = zplane(H) returns vectors of handles to the lines and
    %   text objects generated. HZ is a vector of handles to the zeros
    %   lines, HP is a vector of handles to the poles lines, and Hl is a
    %   vector of handles to the axes / unit circle line and to text
    %   objects which are present when there are multiple zeros or poles.
    %   In case there are no zeros or no poles, HZ or HP is set to the
    %   empty matrix [].
    %
    %   For additional parameters, see signal/zplane.

    prepareFilter(obj)
    [HZ,HP,Hl] = zplane(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function c = cost(obj,varargin)
    %COST   Cost estimate for implementation of filter System object
    %   C = cost(H) return a cost estimate C for the filter System object,
    %   H. The cost estimate contains the following fields:
    %   NMULT              : Number of multipliers (excluding multiplications by 0,1,-1)
    %   NADD               : Number of adders
    %   NSTATES            : Number of states
    %   MULTPERINPUTSAMPLE : Number of multiplications per input sample
    %   ADDPERINPUTSAMPLE  : Number of additions per input sample
    %
    %   C = cost(H,'Arithmetic',ARITH,...) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double', 'single', or 'fixed'. The
    %   analysis tool assumes a double precision filter when the arithmetic
    %   input is not specified and the filter System object is in an
    %   unlocked state.

    prepareFilter(obj)
    c = cost(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function m = measure(obj,varargin)
    %MEASURE  Measure frequency response characteristics of filter
    %   measure(H) displays measurements of various quantities from the
    %   frequency response of the filter System object, H. Values that are
    %   measured can include the actual passband ripple, the minimum
    %   stopband attenuation, the frequency point at which the filter's
    %   gain is 3 dB below the nominal passband gain, etc. In order for
    %   measure to work, the filter H needs to be designed using FDESIGN.
    %
    %   M = measure(H) returns the measurements, M, such that they can be
    %   queried programmatically. For example, to query the 3 dB point, one
    %   would type M.F3dB. Type GET(M) to see the full list of properties
    %   that can be queried. Note that different filter responses will
    %   generate different measurements.
    %
    %   M = measure(H,'Arithmetic',ARITH,...) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double', 'single', or 'fixed'. The
    %   analysis tool assumes a double precision filter when the arithmetic
    %   input is not specified and the filter System object is in an
    %   unlocked state.
    %
    %   For designs that do not specify some of the frequency constraints,
    %   it may not be possible to determine corresponding magnitude
    %   measurements. In these cases, a frequency value can be passed in to
    %   measure in order to determine the magnitude measurements that
    %   corresponds to such value.
    %
    %   %   Example #1: Measure an equiripple FIR design of a bandpass
    %   %               filter
    %   f = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',...
    %                         0.3,0.4,0.6,0.7,80,1,75);
    %   H = design(f,'equiripple','SystemObject',true);
    %   measure(H)
    %
    %   % Example #2: Specify the passband frequency of the filter
    %   f = fdesign.lowpass('N,F3dB,Ast',8,0.5,80);
    %   H = design(f,'cheby2','SystemObject',true);
    %   measure(H,'Fpass',0.4)

    prepareFilter(obj)
    m = measure(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function N = order(obj,varargin)
    %ORDER  Order of discrete-time filter System object
    %   N = order(H) returns the order, N, of the filter System object, H.
    %   The order depends on the filter structure and the reference
    %   double-precision floating-point coefficients.

    % This analysis is insensitive to the filter arithmetic. Parse the
    % arithmetic just to get rid of a possible arithmetic input. We do
    % not prevent users from passing the arithmetic input for consistency
    % of all the analysis methods.
    prepareFilter(obj)
    N = order(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function s = coeffs(obj,varargin)
    %COEFFS Returns the filter System object coefficients in a structure
    %   S = coeffs(H) Returns the coefficients of filter System object, H,
    %   in the structure S.
    %
    %   S = coeffs(H,'Arithmetic',ARITH,...) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double', 'single', or 'fixed'. The
    %   analysis tool assumes a double precision filter when the arithmetic
    %   input is not specified and the filter System object is in an
    %   unlocked state. The coeffs method returns the quantized filter
    %   coefficients when ARITH is set to 'single' or 'fixed'.

    prepareFilter(obj)
    s = coeffs(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function t = firtype(obj,varargin)
    %FIRTYPE Determine the type (1-4) of a linear phase FIR filter
    %   T = firtype(H) determines the type (1 through 4) of the FIR filter
    %   System object H. The filter must be real and have linear phase.
    %
    %   Types 1 through 4 are defined as follows:
    %
    %   Type 1: Even order symmetric coefficients.
    %   Type 2: Odd order symmetric coefficients.
    %   Type 3: Even order antisymmetric coefficients.
    %   Type 4: Odd order antisymmetric coefficients.

    prepareFilter(obj)
    t = firtype(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function [b,a] = tf(obj,varargin)
    %TF Convert discrete-time filter System object to transfer function
    %   [NUM,DEN] = tf(H) converts discrete-time filter System object, H,
    %   to numerator and denominator vectors.
    %
    %   [NUM,DEN] = tf(H,'Arithmetic',ARITH) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double', 'single', or 'fixed'. The
    %   analysis tool assumes a double precision filter when the arithmetic
    %   input is not specified and the filter System object is in an
    %   unlocked state.

    prepareFilter(obj)
    [b,a] = tf(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function [z,p,k] = zpk(obj,varargin)
    %ZPK Zero-pole-gain conversion of discrete-time filter System object
    %   [Z,P,K] = zpk(H) returns the zeros, poles, and gain corresponding
    %   to the filter System object, H, in vectors Z, P, and scalar K
    %   respectively.
    %
    %   [Z,P,K] = zpk(H,'Arithmetic',ARITH) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double', 'single', or 'fixed'. The
    %   analysis tool assumes a double precision filter when the arithmetic
    %   input is not specified and the filter System object is in an
    %   unlocked state.

    prepareFilter(obj)
    [z,p,k] = zpk(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function [A,B,C,D] = ss(obj,varargin)
    %SS     Convert discrete-time filter to state-space representation
    %   [A,B,C,D] = ss(H) converts filter System object, H, to
    %   state-space representation given by:
    %   x(k+1) = A*x(k) + B*u(k)
    %   y(k)   = C*x(k) + D*u(k)
    %   where x is the state vector, u is the input vector, and y is the
    %   output vector.
    %
    %   [A,B,C,D] = ss(H,'Arithmetic',ARITH) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double', 'single', or 'fixed'. The
    %   analysis tool assumes a double precision filter when the arithmetic
    %   input is not specified and the filter System object is in an
    %   unlocked state.

    prepareFilter(obj)
    [A,B,C,D] = ss(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function flag = isallpass(obj,varargin)
    %ISALLPASS Verify that discrete-time filter System object is allpass
    %   FLAG = isallpass(H) returns true if filter System object, H, is
    %   all-pass.
    %
    %   FLAG = isallpass(H,TOL) uses tolerance TOL to determine when two
    %   numbers are close enough to be considered equal.
    %
    %   FLAG = isallpass(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.

    prepareFilter(obj)
    flag = isallpass(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function flag = islinphase(obj,varargin)
    %ISLINPHASE Verify that discrete-time filter is linear phase
    %   FLAG = islinphase(H) returns true if filter System object, H, is
    %   linear phase.
    %
    %   FLAG = islinphase(H,TOL) uses tolerance TOL to determine when two
    %   numbers are close enough to be considered equal.
    %
    %   FLAG = islinphase(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.

    prepareFilter(obj)
    flag = islinphase(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function flag = ismaxphase(obj,varargin)
    %ISMAXPHASE Verify that discrete-time filter is maximum phase
    %   FLAG = ismaxphase(H) returns true if filter System object, H, is
    %   maximum phase.
    %
    %   FLAG = ismaxphase(H,TOL) uses tolerance TOL to determine when two
    %   numbers are close enough to be considered equal.
    %
    %   FLAG = ismaxphase(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.

    prepareFilter(obj)
    flag = ismaxphase(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function flag = isminphase(obj,varargin)
    %ISMINPHASE Verify that discrete-time filter is minimum phase
    %   FLAG = isminphase(H) returns true if filter System object, H, is
    %   maximum phase.
    %
    %   FLAG = isminphase(H,TOL) uses tolerance TOL to determine when two
    %   numbers are close enough to be considered equal.
    %
    %   FLAG = isminphase(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.

    prepareFilter(obj)
    flag = isminphase(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function flag = isreal(obj,varargin)
    %ISREAL Verify that discrete-time filter System object is real
    %   FLAG = isreal(H) returns true if filter System object, H, has real
    %   coefficients.

    prepareFilter(obj)
    flag = isreal(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function flag = isstable(obj,varargin)
    %ISSTABLE Verify that discrete-time filter System object is stable
    %   FLAG = isstable(H) returns true if filter System object, H, is
    %   stable.
    %
    %   FLAG = isstable(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.

    prepareFilter(obj)
    flag = isstable(obj.pFilter,varargin{:});
  end

  %----------------------------------------------------------------------
  function flag = isfir(obj,varargin)
    %ISFIR  Verify if discrete-time System object filter is FIR
    %   FLAG = isfir(H) returns true if filter System object, H, is FIR.

    prepareFilter(obj)
    flag = isfir(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function flag = issos(obj,varargin)
    %ISSOS  Verify if discrete-time filter is in second-order sections form
    %   FLAG = issos(H) returns true if filter System object, H, is in
    %   second-order sections form.

    prepareFilter(obj)
    flag = issos(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function realizemdl(obj,varargin)
    %REALIZEMDL Filter realization (Simulink diagram)
    %   realizemdl(H) automatically generates architecture model of filter
    %   System object, H, in a Simulink subsystem block using individual
    %   sum, gain, and delay blocks, according to user-defined
    %   specifications.
    %
    %   realizemdl(H,'Arithmetic',ARITH,...) analyzes the filter System
    %   object, H, based on the arithmetic specified in the ARITH input.
    %   ARITH can be set to one of 'double' or 'single'. The analysis tool
    %   assumes a double precision filter when the arithmetic input is not
    %   specified. The realizemdl method for filter System objects does not
    %   support fixed-point arithmetic.
    %
    %   realizemdl(H, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...)
    %   generates the model with parameter/value pairs. Valid properties
    %   and values for realizemdl are listed in this table, with the
    %   default value noted and descriptions of what the properties do.
    %
    %     -------------       ---------------      ----------------------------
    %     Property Name       Property Values      Description
    %     -------------       ---------------      ----------------------------
    %     Destination         [{'current'}         Specify whether to add the block
    %                          'new'               to your current Simulink model,
    %                          <user defined>]     create a new model to contain the
    %                                              block, or specify the name of the
    %                                              target subsystem.
    %
    %     Blockname           {'filter'}           Provides the name for the new
    %                                              subsystem block. By default the
    %                                              block is named 'filter'.
    %
    %     OverwriteBlock      ['on' {'off'}]       Specify whether to overwrite an
    %                                              existing block with the same name
    %                                              as specified by the Blockname
    %                                              property or create a new block.
    %
    %     OptimizeZeros       [{'on'} 'off']       Specify whether to remove zero-gain
    %                                              blocks.
    %
    %     OptimizeOnes        [{'on'} 'off']       Specify whether to replace unity-gain
    %                                              blocks with direct connections.
    %
    %     OptimizeNegOnes     [{'on'} 'off']       Specify whether to replace negative
    %                                              unity-gain blocks with a sign
    %                                              change at the nearest sum block.
    %
    %     OptimizeDelayChains [{'on'} 'off']       Specify whether to replace cascaded
    %                                              chains of delay blocks with a
    %                                              single integer delay block to
    %                                              provide an equivalent delay.
    %
    %     MapStates           ['on' {'off'}]       Specify whether to map the States
    %                                              of the filter as initial conditions
    %                                              of the block.
    %
    %     MapCoeffsToPorts    ['on' {'off'}]       Specify whether to map the
    %                                              coefficients of the filter
    %                                              to the ports of the block.
    %
    %     CoeffNames          {'Num'}              Specify the coefficient
    %                                              variables names. MapCoeffsToPorts
    %                                              must be 'on' for this property
    %                                              to apply.
    %
    %     InputProcessing   [{'columnsaschannels'} Specify sample-based
    %                        'elementsaschannels'  ('elementsaschannels') vs.
    %                        'inherited']          frame-based ('columnsaschannels')
    %                                              processing.
    %
    %     RateOption(*)      [{'enforcesinglerate'} Specify how the block adjusts
    %                       'allowmultirate']      the rate at the output to accommodate
    %                                              the reduced number of samples.
    %                                              Apply only to multirate blocks
    %                                              when InputProcessing is set to
    %                                              'columnsaschannels'.

    prepareFilter(obj)
    realizemdl(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function [Hr, W] = freqrespest(obj,varargin)
    %FREQRESPEST  Frequency response estimate via filtering
    %   [Hr,W] = freqrespest(H,L) computes the frequency response estimate
    %   of the filter System object H by running input data made up from
    %   sinusoids with uniformly distributed random frequencies through
    %   the filter and forming the ratio between output data and input
    %   data. This is particularly useful for fixed-point filters, a
    %   frequency response estimate that is close to the frequency response
    %   obtained by using only the quantized coefficients but ignoring the
    %   fixed-point additions/multiplications is a good indication that the
    %   filter's fixed-point performance closely matches a floating point
    %   implementation with the same (quantized) coefficients.
    %
    %   L is the number of trials used to compute the estimate. If not
    %   specified, L defaults to 10. In general, the more trials used, the
    %   more accurate estimate obtained at the expense of a longer time
    %   needed to compute the estimate.
    %
    %   Hr is the estimate of the complex frequency response. W is a vector
    %   of frequencies at which H is estimated.
    %
    %   [Hr,W] = freqrespest(H,L,P1,V1,P2,V2,...) specifies optional
    %   parameters via parameter-value pairs. Valid pairs are:
    %
    %         Parameter           Default        Description/Valid values
    %   ---------------------  -----------  ----------------------------------
    %    'NFFT'                 512          Number of FFT points.
    %    'NormalizedFrequency'  true         {true,false}
    %    'Fs'                   'Normalized' Sampling frequency. Only used when
    %                                        'NormalizedFrequency' is false.
    %    'SpectrumRange'        'Half'       {'Half','Whole'}
    %    'CenterDC'             false        {true,false}
    %
    %   [Hr, W] = freqrespest(H,L,OPTS) uses an options object to specify
    %   the optional parameters in lieu of specifying parameter-value
    %   pairs. The OPTS object can be created with OPTS = freqrespopts(H).
    %   Settings can be changed in OPTS before calling freqrespest, e.g.
    %   set(OPTS,'Fs',48e3);
    %
    %   [Hr,W] = freqrespest(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.
    %
    %   freqrespest(H,...) with no output argument launches FVTool and
    %   shows the magnitude response estimate of the filter System object,
    %   H.

    prepareFilter(obj)
    [Hr, W] = freqrespest(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function OPTS = freqrespopts(obj,varargin)
    %FREQRESPOPTS Create an options object for frequency response estimate
    %   OPTS = freqrespopts(H) uses the current settings in the filter
    %   System object H to create an options object OPTS that contains
    %   options for frequency response estimation.  The OPTS object can be
    %   passed in as an argument to the FREQRESPEST method.

    prepareFilter(obj)
    OPTS = freqrespopts(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function Hpsd = noisepsd(obj,varargin)
    %NOISEPSD Power spectral density of filter output due to roundoff noise
    %   Hpsd = noisepsd(H,L) computes the power spectral density (PSD) at
    %   the output of the filter System object H due to roundoff noise
    %   produced by quantization errors within the filter. The PSD is
    %   computed from an average over the L trials. The larger the number
    %   of trials, the better the estimate (at the expense of longer
    %   computation time). If L is not specified, it defaults to 10 trials.
    %
    %   Output Hpsd is a PSD data object. The PSD vector can be extracted
    %   from Hpsd using GET(Hpsd,'Data') and it can be plotted using
    %   PLOT(Hpsd). The average power of the output noise (the integral of
    %   the PSD) can be computed using AVGPOWER(Hpsd).
    %
    %   Hpsd = noisepsd(H,L,P1,V1,P2,V2,...) specifies optional parameters
    %   via parameter-value pairs. Valid pairs are:
    %
    %        Parameter           Default        Description/Valid values
    %   ---------------------  -----------  ----------------------------------
    %   'NFFT'                 512          Number of FFT points.
    %   'NormalizedFrequency'  true         {true,false}
    %   'Fs'                   'Normalized' Sampling frequency. Only used when
    %                                       'NormalizedFrequency' is false.
    %   'SpectrumType'         'Onesided'   {'Onesided','Twosided'}
    %   'CenterDC'             false        {true,false}
    %
    %   Hpsd = noisepsd(H,L,OPTS) uses an options object to specify the
    %   optional parameters in lieu of specifying parameter-value pairs.
    %   The OPTS object can be created with OPTS = noisepsdopts(H).
    %   Settings can be changed in OPTS before calling noisepsd, e.g.
    %   set(OPTS,'Fs',48e3);
    %
    %   Hpsd = noise(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.
    %
    %   noisepsd(H,...) with no output argument launches FVTool and shows
    %   the noise PSD estimate of the filter System object, H.

    prepareFilter(obj)
    Hpsd = noisepsd(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function OPTS = noisepsdopts(obj,varargin)
    %NOISEPSDOPTS Create an options object for output noise PSD computation
    %   OPTS = noisepsdopts(H) uses the current settings in the filter
    %   System object H to create an options object OPTS that contains
    %   options for output noise PSD computation.  The OPTS object can be
    %   passed in as an argument to the noisepsd method.

    prepareFilter(obj)
    OPTS = noisepsdopts(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function specifyall(obj,varargin)
    %SPECIFYALL Fully specify fixed-point filter System object settings
    %   specifyall(H) sets all the data type fixed-point properties of the
    %   filter System object, H, to 'Custom' so that you can easily specify
    %   all the fixed-point settings. If the object has a
    %   FullPrecisionOverride property, its value is set to false.
    %   specifyall is intended as a shortcut to changing all the
    %   fixed-point properties one-by-one.
    %
    %   specifyall(H,FLAG) when FLAG is false, is essentially the opposite
    %   of specifyall(H). All fixed-point properties are set to their
    %   default values and the filter is set to full precision mode if one
    %   is available.
    %
    %   specifyall(H,FLAG) is equivalent to specifyall(H) when FLAG is
    %   true.

    prepareFilter(obj)
    specifyall(obj.pFilter,varargin{:});
  end
  %----------------------------------------------------------------------
  function P = polyphase(obj,varargin)
    %Polyphase decomposition of System object
    %   P = polyphase(H) returns the polyphase matrix of the filter
    %   System object, H. The ith row of the matrix P represents the ith
    %   subfilter.
    %
    %   P = polyphase(H,'Arithmetic',ARITH,...) analyzes the filter
    %   System object, H, based on the arithmetic specified in the ARITH
    %   input. ARITH can be set to one of 'double', 'single', or 'fixed'.
    %   The analysis tool assumes a double precision filter when the
    %   arithmetic input is not specified and the filter System object is
    %   in an unlocked state.
    %
    %   polyphase(H) called with no outputs launches the Filter
    %   Visualization Tool (FVTool) with all the polyphase subfilters to
    %   allow analyses of each component individually.

    prepareFilter(obj)
    P = polyphase(obj.pFilter,varargin{:});
  end 
end

methods (Access=protected)
  function y = stepImpl(obj, x)
    y = step(obj.pFilter, x);
  end

  function resetImpl(obj)
    reset(obj.pFilter)
  end

  function releaseImpl(obj)
    release(obj.pFilter)
  end


  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      s.pFilter  = matlab.System.saveObject(obj.pFilter);
    end
  end

  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      obj.pFilter  = matlab.System.loadObject(s.pFilter);
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end
  
  function coeffs = designFilter(obj)
    sampsPerSym = getSamplesPerSymbol(obj);
    nSym = obj.FilterSpanInSymbols;
    r = obj.RolloffFactor;  % rolloff factor
    if strncmp(obj.Shape,'Square root',4)
      % square root raised cosine
      b = rcosdesign(r, nSym, sampsPerSym);
    else
      % regular raised cosine
      b = rcosdesign(r, nSym, sampsPerSym, 'normal');
    end

    % Normalize filter taps for unit energy and apply linear gain
    coeffs = (b / sqrt(sum(b.^2))) * obj.Gain;
  end

  function varargout = infoImpl(obj)
    %INFO   Information about filter System object
    %   S = info(H) returns a string matrix with information about the
    %   filter System object, H.

    prepareFilter(obj)
    if nargout == 1
      varargout{1} = info(obj.pFilter);
    else
      info(obj.pFilter);
    end      
  end
  
  function prepareFilter(obj)
    if ~isempty(coder.target)
      % this function is not supported for code generation since it uses
      % the release method
      coder.internal.assert(false, ...
        'comm:RaisedCosineFilterBase:AnalysisCodeGen');
    end
    
    if ~isLocked(obj)
      % We need to create the underlying filter first. Call setup to create
      % pFilter and then release. 
      setup(obj, 1);
      release(obj)
    end
  end
end
end
