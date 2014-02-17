classdef GeneralQAMTCMModulator < matlab.System
%GeneralQAMTCMModulator Convolutionally encode binary data and map using
%arbitrary QAM constellation
%   H = comm.GeneralQAMTCMModulator creates a trellis-coded, general
%   quadrature amplitude (QAM TCM) modulator System object, H. This object
%   convolutionally encodes a binary input signal and maps the result using
%   QAM modulation with a signal constellation specified in the
%   Constellation property.
%
%   H = comm.GeneralQAMTCMModulator(Name,Value) creates a general QAM TCM
%   modulator System object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.GeneralQAMTCMModulator(TRELLIS,Name,Value) creates a general
%   QAM TCM modulator System object, H, with the TrellisStructure property
%   set to TRELLIS and other specified property Names set to the specified
%   Values.
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
%   Y = step(H,X,R) resets the encoder of the general QAM TCM modulator
%   object to the all-zeros state when you input a non-zero reset signal, R.
%   R must be a double precision or logical scalar integer. This syntax
%   applies when you set the ResetInputPort property to true.
%  
%   GeneralQAMTCMModulator methods:
%
%   step     - Modulate using general QAM TCM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create general QAM TCM modulator object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the general QAM TCM modulator object
%   
%   GeneralQAMTCMModulator properties:
%
%   TrellisStructure  - Trellis structure of convolutional code
%   TerminationMethod - Termination method of encoded frame
%   ResetInputPort    - Enable modulator reset input
%   Constellation     - Signal constellation
%   OutputDataType    - Data type of output
%
%   % Example:
%   %   Modulate data using QAM TCM modulation with an arbitrary four-point 
%   %   constellation
%
%   % Create binary data.
%   data = randi([0 1], 1000,1); 
%   % Use the trellis structure with generating polynomial [171 133] and 
%   % 4-point arbitrary constellation exp(1i*pi*[1 2 3 6]/4) to perform 
%   % QAM TCM modulation
%   t = poly2trellis(7,[171 133]);
%   hMod = comm.GeneralQAMTCMModulator(t,...
%                   'Constellation', exp(pi*1i*[1 2 3 6]/4));
%   % Modulate and plot the data
%   modData = step(hMod, data);
%   scatterplot(modData);
%
%   See also comm.GeneralQAMTCMDemodulator, comm.GeneralQAMModulator,
%            comm.PSKTCMModulator, comm.ConvolutionalEncoder.

%   Copyright 2008-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.10 $Date: 2012/06/13 08:48:40 $

%#codegen
%#ok<*EMCLS>

properties (Nontunable)  
  %TrellisStructure Trellis structure of convolutional code
  %   Specify trellis as a MATLAB structure that contains the trellis
  %   description of the convolutional code. Use the istrellis function to
  %   check if a structure is a valid trellis structure. The default is the
  %   result of poly2trellis([1 3], [1 0 0; 0 5 2]).
  %
  %   See also istrellis, poly2trellis.
  TrellisStructure = poly2trellis([1 3],[1 0 0; 0 5 2]);
  %TerminationMethod Termination method of encoded frame
  %   Specify the termination method as one of 'Continuous' | 'Truncated' |
  %   'Terminated'. The default is 'Continuous'.
  %
  %   When you set this property to 'Continuous', the System object retains
  %   the encoder states at the end of each input vector for use with the
  %   next input vector.
  %
  %   When you set this property to 'Truncated', the object treats each
  %   input vector independently. The encoder is reset to the all-zeros
  %   state at the start of each input vector.
  %
  %   When you set this property to 'Terminated', the object treats each
  %   input vector independently. For each input vector, extra bits are used
  %   to set the encoder to the all-zeros state at the end of the vector.
  %   For a rate K/N code, the step method outputs the vector with length  y
  %   = N*(L+S)/K, where S = constraintLength-1 (or, in the case of multiple
  %   constraint lengths, S = sum(constraintLength(i)-1)). L is the length
  %   of the input to the step method.
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
  %Constellation Signal constellation
  %   Specify a double or single precision complex vector that lists the
  %   points in the signal constellation used to map the convolutionally
  %   encoded data. The constellation must be specified in set-partitioned
  %   order. See documentation for the General TCM Encoder block for more
  %   information on set-partitioned order. The length of the constellation
  %   vector must equal the number of possible output symbols from the
  %   convolutional encoder of the general QAM TCM modulator object. This
  %   corresponds to 2^N for a rate K/N convolutional code. The default
  %   value corresponds to a set-partitioned order for the points of an
  %   8-PSK signal constellation, which is exp(2*pi*1i*[0 4 2 6 1 5 3 7]/8).
  Constellation = exp(2*pi*1i*[0 4 2 6 1 5 3 7]/8);
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
  % CONSTRUCTOR
  function obj = GeneralQAMTCMModulator(varargin)
    setProperties(obj, nargin, varargin{:}, 'TrellisStructure');    
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
  
  function  [constellationPoints, modulationOrder, intDataType, err] = ...
      getInitializationParameters(obj)
    
    % input validation and initialization
    [constellationPoints, modulationOrder, err, ~, ~] = ...
      commblkgentcmenc(obj, 'init', obj.TrellisStructure, ...
      obj.Constellation, true);
       
    % Setup private System objects
    intDataType = 'uint32';
  end  
  
  function flag = isInactivePropertyImpl(obj, prop)
    props = {}; %#ok<EMCA>
    if ~strcmp(obj.TerminationMethod, 'Continuous')
      props = [props, {'ResetInputPort'}]; %#ok<EMCA>
    end
    flag = ismember(prop, props);          
  end                 
  
  function resetImpl(obj)
    reset(obj.cConvolutionalEncoder);
    reset(obj.cBitToIntegerConverter);
    reset(obj.cGeneralQAMModulator);
  end
  
  function releaseImpl(obj)
    release(obj.cConvolutionalEncoder);
    release(obj.cBitToIntegerConverter);
    release(obj.cGeneralQAMModulator);
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


