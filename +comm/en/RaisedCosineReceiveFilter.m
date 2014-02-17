classdef RaisedCosineReceiveFilter< handle
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

    methods
        function out=RaisedCosineReceiveFilter
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
        end

        function getSamplesPerSymbol(in) %#ok<MANU>
        end

        function helpFilterAnalysis(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %DecimationFactor Decimation factor
        %   Specify the factor by which the object reduce the sampling rate of
        %   the input signal. The default value is 8. This property accepts a
        %   positive integer scalar value between 1 and InputSamplesPerSymbol.
        %   The value must evenly divide into InputSamplesPerSymbol. The number
        %   of input rows must be a multiple of the decimation factor. If you
        %   set DecimationFactor to 1, then the object only applies filtering
        %   without downsampling.
        DecimationFactor;

        %DecimationOffset Decimation offset 
        %   Specify the number of filtered samples the System object discards
        %   before downsampling. The default is 0. This property accepts an
        %   integer valued scalar between 0 and DecimationFactor-1.
        DecimationOffset;

        %InputSamplesPerSymbol Input samples per symbol
        %   Specify the number of input samples that represent a symbol. The
        %   default is 8. This property accepts an integer valued positive scalar
        %   double or single value. The raised cosine filter has
        %   (FilterSpanInSymbols x InputSamplesPerSymbol + 1) taps.
        InputSamplesPerSymbol;

    end
end
