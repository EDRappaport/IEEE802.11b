classdef RectangularQAMTCMModulator < matlab.System
%RectangularQAMTCMModulator Convolutionally encode binary data and map using
%rectangular QAM constellation
%   H = comm.RectangularQAMTCMModulator creates a trellis-coded, rectangular
%   quadrature amplitude (QAM TCM) modulator System object, H. This object
%   convolutionally encodes a binary input signal and maps the result to a
%   rectangular QAM constellation.
%
%   H = comm.RectangularQAMTCMModulator(Name,Value) creates a rectangular
%   QAM TCM modulator object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.RectangularQAMTCMModulator(TRELLIS,Name,Value) creates a
%   rectangular QAM TCM modulator object, H, with the TrellisStructure
%   property set to TRELLIS and other specified property Names set to the
%   specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) convolutionally encodes and modulates the input binary
%   data column vector, X, and returns the encoded and modulated data, Y. X
%   must be of data type numeric, logical, or unsigned fixed point of word
%   length 1 (fi object). When the convolutional encoder represents a rate
%   K/N code, the length of the input vector, X, must be K*L, for some
%   positive integer L. The step method outputs a complex column vector, Y,
%   of length L.
%
%   Y = step(H,X,R) resets the encoder of the rectangular QAM TCM modulator
%   object to the all-zeros state when you input a non-zero reset signal, R.
%   R must be a double precision or logical, scalar integer. This syntax
%   applies when you set the ResetInputPort property to true.
%
%   RectangularQAMTCMModulator methods:
%
%   step     - Modulate using rectangular QAM TCM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create rectangular QAM TCM modulator object with same 
%              property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the rectangular QAM TCM modulator object
%
%   RectangularQAMTCMModulator properties:
%
%   TrellisStructure  - Trellis structure of convolutional code
%   TerminationMethod - Termination method of encoded frame
%   ResetInputPort    - Enable modulator reset input
%   ModulationOrder   - Number of points in signal constellation
%   OutputDataType    - Data type of output
%
%   % Example:
%   %   Modulate data using rectangular 16-QAM TCM modulation
%
%   % Create binary data.
%   data = randi([0 1], 3000,1); 
%   hMod = comm.RectangularQAMTCMModulator;
%   % Modulate and plot the data.
%   modData = step(hMod, data);
%   scatterplot(modData);
%
%   See also comm.RectangularQAMTCMDemodulator, comm.GeneralQAMTCMModulator,
%            comm.ConvolutionalEncoder.

%   Copyright 2009-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.9 $ $Date: 2012/06/13 08:49:25 $

%#codegen
%#ok<*EMCLS>

properties (Nontunable)  
  %TrellisStructure Trellis structure of convolutional code
  %   Specify trellis as a MATLAB structure that contains the trellis
  %   description of the convolutional code. Use the istrellis function to
  %   check if a structure is a valid trellis structure. The default is the
  %   result of poly2trellis([3 1 1], [ 5 2 0 0; 0 0 1 0; 0 0 0 1]).
  %
  %   See also istrellis, poly2trellis.
  TrellisStructure = poly2trellis([3 1 1], [ 5 2 0 0; 0 0 1 0; 0 0 0 1]);
  %TerminationMethod Termination method of encoded frame
  %   Specify the termination method as one of 'Continuous' | 'Truncated' |
  %   'Terminated'. The default is 'Continuous'.
  %
  %   When you set this property to 'Continuous', the object retains the
  %   encoder states at the end of each input vector for use with the next
  %   input vector.
  %
  %   When you set this property to 'Truncated', the object treats each
  %   input vector independently. The encoder is reset to the all-zeros
  %   state at the start of each input vector.
  %
  %   When you set this property to 'Terminated', the object treats each
  %   input vector independently. For each input vector, extra bits are used
  %   to set the encoder to the all-zeros state at the end of the vector. For
  %   a rate K/N code, the step method outputs the vector with a length
  %   given by y = N*(L+S)/K, where S = constraintLength-1 (or, in the case
  %   of multiple constraint lengths, S = sum(constraintLength(i)-1)). L is
  %   the length of the input to the step method.
  TerminationMethod = 'Continuous';
end

properties (Nontunable, Logical) 
  %ResetInputPort Enable modulator reset input
  %   Set this property to true to enable an additional input to the step
  %   method. When you set the reset input to the step method to a non-zero
  %   value, the object resets the encoder to the all-zeros state. This
  %   property applies when you set the TerminationMethod property to
  %   'Continuous'. The default is false.
  ResetInputPort = false;  
end

properties (Nontunable) 
  %ModulationOrder Number of points in signal constellation
  %   Specify the number of points in the signal constellation used to map
  %   the convolutionally encoded data as a positive, integer scalar equal
  %   to 4, 8, 16, 32, or 64. The value of the ModulationOrder property must
  %   equal the number of possible output symbols from the convolutional
  %   encoder of the rectangular QAM TCM modulator. The value of the
  %   ModulationOrder property must be 2^N for a rate K/N convolutional
  %   code. The default is 16.
  ModulationOrder = 16;      
  %OutputDataType Data type of output
  %   Specify the output data type as one of 'double' | 'single'. The
  %   default is 'double'.
  OutputDataType = 'double';   
end


properties (Constant, Hidden)
  TerminationMethodSet = comm.CommonSets.getSet('TerminationMethod');
  OutputDataTypeSet = comm.CommonSets.getSet('DoubleOrSingle');
end    

properties (Access = private, Nontunable)
  cConvolutionalEncoder;  % Convolutional Encoder private System object
  cBitToIntegerConverter; % Bit to Integer Converter private System object
  cGeneralQAMModulator;   % General QAM Modulator private System object 
end

methods
  function obj = RectangularQAMTCMModulator(varargin)
    setProperties(obj, nargin, varargin{:}, 'TrellisStructure');   
  end 
  
  function set.ModulationOrder(obj,value)
      coder.internal.errorIf(~ismember(value,[4 8 16 32 64]), 'comm:system:RectangularQAMTCMModulator:invalidModulationOrder');
      obj.ModulationOrder = value;    
  end    
end
    
methods(Access = protected)  
  function y = stepImpl(obj, x, varargin)
    % A non-empty varargin contains the input reset signal
    encData = step(obj.cConvolutionalEncoder, x, varargin{:});
    intData = step(obj.cBitToIntegerConverter, encData);
    y = step(obj.cGeneralQAMModulator, intData);
  end
  
  function num = getNumInputsImpl(obj)
    num = 1 + ...
      (strcmp(obj.TerminationMethod,'Continuous') && obj.ResetInputPort);
  end
  
  function flag = isInputSizeLockedImpl(~,~)
      flag = true;
  end
  
  function flag = isInputComplexityLockedImpl(~,~)
    flag = true;
  end
  
  function flag = isOutputComplexityLockedImpl(~,~)
    flag = true;
  end
    
  function setupImpl(obj, ~, varargin)
    % Initialization
    [constellationPoints, modulationOrder, intDataType, err] = ...
      getInitializationParameters(obj);
    
    if ~isempty(err.msg)
      matlab.system.internal.errorInSetup(err.mmi, err.msg);
    end
    
    % setup the private Convolutional Encoder System object
    if (strcmp(obj.TerminationMethod,'Continuous'))
      obj.cConvolutionalEncoder = comm.ConvolutionalEncoder( ...
        'TrellisStructure', obj.TrellisStructure, ...
        'TerminationMethod', obj.TerminationMethod, ...
        'ResetInputPort', obj.ResetInputPort);
    else
      obj.cConvolutionalEncoder = comm.ConvolutionalEncoder( ...
        'TrellisStructure', obj.TrellisStructure, ...
        'TerminationMethod', obj.TerminationMethod);
    end
    
    % setup the private Bit To Integer Converter System object
    obj.cBitToIntegerConverter = comm.BitToInteger( ...
      'BitsPerInteger', log2(modulationOrder), ...
      'OutputDataType', intDataType);
    
    % setup the private General QAM Modulator System object with an M-PSK
    % constellation.
    obj.cGeneralQAMModulator = comm.GeneralQAMModulator( ...
      'Constellation', constellationPoints, ...
      'OutputDataType', obj.OutputDataType);
  end
  
  function resetImpl(obj)
    reset(obj.cConvolutionalEncoder)
    reset(obj.cBitToIntegerConverter)
    reset(obj.cGeneralQAMModulator)
  end
  
  function releaseImpl(obj)
    release(obj.cConvolutionalEncoder)
    release(obj.cBitToIntegerConverter)
    release(obj.cGeneralQAMModulator)
  end
  
  function  [constellationPoints, modulationOrder, intDataType, err] = ...
      getInitializationParameters(obj)
    
    % input validation and initialization
    [constellationPoints, err] = commblkqamtcmenc(obj, 'init', ...
      obj.TrellisStructure, obj.ModulationOrder, true);
    
    intDataType = 'uint8';
    modulationOrder = obj.ModulationOrder;
  end
  
  function flag = isInactivePropertyImpl(obj, prop)
    flag = false;
    if strcmp(prop, 'ResetInputPort') ...
        && ~strcmp(obj.TerminationMethod, 'Continuous')
      flag = true;
    end
  end                 
  
  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      s.cConvolutionalEncoder = ...
        matlab.System.saveObject(obj.cConvolutionalEncoder);
      s.cBitToIntegerConverter = ...
        matlab.System.saveObject(obj.cBitToIntegerConverter);
      s.cGeneralQAMModulator = ...
        matlab.System.saveObject(obj.cGeneralQAMModulator);
    end
  end
  
  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      obj.cConvolutionalEncoder = ...
        matlab.System.loadObject(s.cConvolutionalEncoder);
      obj.cBitToIntegerConverter = ...
        matlab.System.loadObject(s.cBitToIntegerConverter);
      obj.cGeneralQAMModulator = ...
        matlab.System.loadObject(s.cGeneralQAMModulator);
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end
end
end
