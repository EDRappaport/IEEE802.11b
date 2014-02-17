classdef RaisedCosineReceiveFilter < comm.internal.RaisedCosineFilterBase
%RaisedCosineReceiveFilter Decimate using raised cosine filter
%   H = comm.RaisedCosineReceiveFilter returns a raised cosine receive
%   filter System object, H, which decimates the input signal. The filter
%   uses an efficient polyphase FIR decimation structure and has unit
%   energy.
%
%   H = RaisedCosineReceiveFilter('PropertyName', PropertyValue, ...)
%   returns a raised cosine receive filter object, H, with each specified
%   property set to the specified value.
%
%   Step method syntax:
%
%   Y = step(H, X) outputs the decimated values, Y, of the input signal X.
%   A Ki-by-N input matrix is treated as N independent channels. The System
%   object filters each channel over time and generates a Ko-by-N output
%   matrix. Ko = Ki/M where M is the decimation factor. The object supports
%   real and complex floating-point inputs.
%
%   RaisedCosineReceiveFilter methods:
%
%   step     - See above description for use of this method
%   release  - Allow property value and input characteristics changes
%   clone    - Create receive filter object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset the internal states to initial conditions
%   coeffs   - Returns the filter System object coefficients in a structure
%
%   RaisedCosineReceiveFilter properties:
%
%   Shape                 - Filter shape
%   RolloffFactor         - Rolloff factor
%   FilterSpanInSymbols   - Filter span in symbols 
%   InputSamplesPerSymbol - Input samples per symbol
%   DecimationFactor      - Decimation factor
%   DecimationOffset      - Decimation offset 
%   Gain                  - Linear filter gain
%
%   This System object supports several filter analysis methods. For more
%   information, type comm.RaisedCosineReceiveFilter.helpFilterAnalysis.
%
%   % EXAMPLE 1: Filter using a square root raised cosine filter. Input 
%   %            signal has eight samples per symbol and output should 
%   %            have an oversampling rate of two. 
%
%   hTxFlt = comm.RaisedCosineTransmitFilter('OutputSamplesPerSymbol', 8);
%   x = 2*randi([0 1], 100, 1) - 1;
%   y = step(hTxFlt, x); 
%   hRxFlt1 = comm.RaisedCosineReceiveFilter('InputSamplesPerSymbol', 8,...
%                                            'DecimationFactor', 4);
%   fvtool(hRxFlt1, 'Analysis', 'impulse')
%   r = step(hRxFlt1, y); 
%
%   % EXAMPLE 2: Filter using a square root raised cosine filter that is
%   %            truncated to six symbol durations. In other words, the 
%   %            filter spans six symbol durations.
%
%   hTxFlt = comm.RaisedCosineTransmitFilter('FilterSpanInSymbols', 6);
%   x = 2*randi([0 1], 100, 1) - 1;
%   y = step(hTxFlt, x); 
%   hRxFlt2 = comm.RaisedCosineReceiveFilter('FilterSpanInSymbols', 6);
%   r = step(hRxFlt2, y); 
%   plot(r, '*'); grid on
%
%   See also comm.RaisedCosineTransmitFilter, dsp.FIRDecimator.

%   Copyright 2012-2013 The MathWorks, Inc.

%#codegen

properties (Nontunable)
  %InputSamplesPerSymbol Input samples per symbol
  %   Specify the number of input samples that represent a symbol. The
  %   default is 8. This property accepts an integer valued positive scalar
  %   double or single value. The raised cosine filter has
  %   (FilterSpanInSymbols x InputSamplesPerSymbol + 1) taps.
  InputSamplesPerSymbol = 8;
  %DecimationFactor Decimation factor
  %   Specify the factor by which the object reduce the sampling rate of
  %   the input signal. The default value is 8. This property accepts a
  %   positive integer scalar value between 1 and InputSamplesPerSymbol.
  %   The value must evenly divide into InputSamplesPerSymbol. The number
  %   of input rows must be a multiple of the decimation factor. If you
  %   set DecimationFactor to 1, then the object only applies filtering
  %   without downsampling.
  DecimationFactor = 8;
  %DecimationOffset Decimation offset 
  %   Specify the number of filtered samples the System object discards
  %   before downsampling. The default is 0. This property accepts an
  %   integer valued scalar between 0 and DecimationFactor-1.
  DecimationOffset = 0;
end

methods
  function obj = RaisedCosineReceiveFilter(varargin)    
     obj@comm.internal.RaisedCosineFilterBase(varargin{:})
  end
  
  function set.InputSamplesPerSymbol(obj, aVal)
    validateattributes(aVal, {'numeric'}, ...
      {'scalar', 'real', 'positive', 'finite', 'integer'}, ...
      '', 'InputSamplesPerSymbol') %#ok<EMCA>
    
    obj.InputSamplesPerSymbol = aVal;
  end
  
  function set.DecimationFactor(obj, aVal)
    validateattributes(aVal, {'numeric'}, ...
      {'scalar', 'real', 'positive', 'finite', 'integer'}, ...
      '', 'DecimationFactor') %#ok<EMCA>
    
    obj.DecimationFactor = aVal;
  end
  
  function set.DecimationOffset(obj, aVal)
    validateattributes(aVal, {'numeric'}, ...
      {'scalar', 'real', 'nonnegative', 'finite', 'integer'}, ...
      '', 'DecimationOffset') %#ok<EMCA>
    
    obj.DecimationOffset = aVal;
  end
end

methods (Access=protected)
  function setupImpl(obj, ~)
    coeffs = designFilter(obj);
    obj.pFilter = dsp.FIRDecimator(obj.DecimationFactor, ...
      coeffs, ...
      'DecimationOffset', obj.DecimationFactor - obj.DecimationOffset);
  end

  function nSamp = getSamplesPerSymbol(obj)
    nSamp = obj.InputSamplesPerSymbol;
  end
  
  function validatePropertiesImpl(obj)
    sps = obj.InputSamplesPerSymbol;
    decim = obj.DecimationFactor;
    coder.internal.errorIf(round(sps / decim) * decim ~= sps, ...
      'comm:RaisedCosineReceiveFilter:InvalidDecimationFactor');
    
    coder.internal.errorIf(obj.DecimationOffset >= decim, ...
      'comm:RaisedCosineReceiveFilter:InvalidDecimationOffset');
  end
end

methods (Static)
  function helpFilterAnalysis
    dsp.FIRDecimator.helpFilterAnalysis
  end
end

methods(Static,Hidden,Access=protected)
  function groups = getPropertyGroupsImpl
    props = {'Shape', ...
             'RolloffFactor', ...
             'FilterSpanInSymbols', ...
             'InputSamplesPerSymbol', ...
             'DecimationFactor', ...
             'DecimationOffset', ...
             'Gain'}; %#ok<EMCA>
    groups = matlab.system.display.Section('Title', 'Parameters', ...
                                           'PropertyList', props);
  end
end
end
