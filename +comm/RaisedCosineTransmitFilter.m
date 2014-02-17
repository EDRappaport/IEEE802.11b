classdef RaisedCosineTransmitFilter < comm.internal.RaisedCosineFilterBase
%RaisedCosineTransmitFilter Interpolate using raised cosine filter
%   H = comm.RaisedCosineTransmitFilter returns a raised cosine transmit
%   filter System object, H, which  interpolates an input signal using a
%   raised cosine FIR filter. The filter uses an efficient polyphase FIR
%   interpolation structure and has unit energy.
%
%   H = RaisedCosineTransmitFilter('PropertyName', PropertyValue, ...)
%   returns a raised cosine transmit filter object, H, with each specified
%   property set to the specified value.
%
%   Step method syntax:
%
%   Y = step(H, X) outputs the interpolated values, Y, of the input signal
%   X. A Ki-by-N input matrix is treated as N independent channels. The
%   System object interpolates each channel over the first dimension and
%   generates a Ko-by-N output matrix, where Ko = Ki*L and L is the output
%   samples per symbol. The object supports real and complex floating-point
%   inputs.
%
%   RaisedCosineTransmitFilter methods:
%
%   step     - See above description for use of this method
%   release  - Allow property value and input characteristics changes
%   clone    - Create transmit filter object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset the internal states to initial conditions
%   coeffs   - Returns the filter System object coefficients in a structure
%
%   RaisedCosineTransmitFilter properties:
%
%   Shape                  - Filter shape
%   RolloffFactor          - Rolloff factor
%   FilterSpanInSymbols    - Filter span in symbols 
%   OutputSamplesPerSymbol - Output samples per symbol
%   Gain                   - Linear filter gain
%
%   This System object supports several filter analysis methods. For more
%   information, type comm.RaisedCosineTransmitFilter.helpFilterAnalysis.
%
%   % EXAMPLE 1: Interpolate using a square root raised cosine filter. 
%   %            The output signal should have eight samples per symbol. 
%
%   hTxFlt1 = comm.RaisedCosineTransmitFilter('OutputSamplesPerSymbol', 8);
%   fvtool(hTxFlt1, 'Analysis', 'impulse')
%   x = 2*randi([0 1], 100, 1) - 1;
%   y = step(hTxFlt1, x); 
%   plot(y); grid on
%
%   % EXAMPLE 2: Interpolate using a square root raised cosine filter 
%   %            that is truncated to six symbol durations. In other 
%   %            words, the filter spans six symbol durations.
%
%   hTxFlt2 = comm.RaisedCosineTransmitFilter('FilterSpanInSymbols', 6);
%   fvtool(hTxFlt2, 'Analysis', 'impulse')
%   x = 2*randi([0 1], 96, 1) - 1;
%   y = step(hTxFlt2, x); 
%   plot(y); grid on
%
%   See also comm.RaisedCosineReceiveFilter, dsp.FIRInterpolator.

%   Copyright 2012-2013 The MathWorks, Inc.

%#codegen

properties (Nontunable)
  %OutputSamplesPerSymbol Output samples per symbol
  %   Specify the number of output samples for each input symbol. The
  %   default is 8. This property accepts an integer valued positive scalar
  %   value. The raised cosine filter has (FilterSpanInSymbols x
  %   OutputSamplesPerSymbol + 1) taps.
  OutputSamplesPerSymbol = 8;
end

methods
  function obj = RaisedCosineTransmitFilter(varargin)    
     obj@comm.internal.RaisedCosineFilterBase(varargin{:})
  end 
  
  function set.OutputSamplesPerSymbol(obj, aVal)
    validateattributes(aVal, {'numeric'}, ...
      {'scalar', 'real', 'positive', 'finite', 'integer'}, ...
      '', 'OutputSamplesPerSymbol'); %#ok<EMCA>
    obj.OutputSamplesPerSymbol = aVal;
  end
end

methods (Access=protected)
  function setupImpl(obj, ~)
    coeffs = designFilter(obj);
    obj.pFilter = dsp.FIRInterpolator(obj.OutputSamplesPerSymbol, coeffs);
  end

  function nSamp = getSamplesPerSymbol(obj)
    nSamp = obj.OutputSamplesPerSymbol;
  end
end

methods (Static)
  function helpFilterAnalysis
    dsp.FIRInterpolator.helpFilterAnalysis
  end
end

methods(Static,Hidden,Access=protected)
  function groups = getPropertyGroupsImpl
    props = {'Shape', ...
             'RolloffFactor', ...
             'FilterSpanInSymbols', ...
             'OutputSamplesPerSymbol', ...
             'Gain'}; %#ok<EMCA>
    groups = matlab.system.display.Section('Title', 'Parameters', ...
                                           'PropertyList', props);
  end
end
end
