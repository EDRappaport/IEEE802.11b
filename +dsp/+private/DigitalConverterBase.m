classdef DigitalConverterBase < matlab.System
  %DigitalConverterBase Baseclass for the DigitalDownConverter and
  %DigitalUpconverter classes.
  
%   Copyright 2010-2012 The MathWorks, Inc.
  
properties (Nontunable) 
  %NumAccumulatorBits Number of NCO accumulator bits
  %   Specify this property as an integer scalar in the range [1 128]. This
  %   property applies when you set the Oscillator property to 'NCO'. The
  %   default is 16.
  %  
  %   See also dsp.NCO.
  NumAccumulatorBits = 16;
  %NumQuantizedAccumulatorBits Number of NCO quantized accumulator bits
  %   Specify this property as an integer scalar in the range [1 128]. The
  %   value you specify in the NumQuantizedAccumulatorBits property must be
  %   less than the value you specify in the NumAccumulatorBits property.
  %   This property applies when you set the Oscillator property to 'NCO'.
  %   The default is 12.
  %  
  %   See also dsp.NCO.  
  NumQuantizedAccumulatorBits = 12;
  %NumDitherBits Number of NCO dither bits
  %   Specify this property as an integer scalar smaller than the number of
  %   accumulator bits that you specify in the NumAccumulatorBits property.
  %   This property applies when you set the Oscillator property to 'NCO'
  %   and the Dither property to true. The default is 4.
  %  
  %   See also dsp.NCO.  
  NumDitherBits = 4;  
end

properties (Logical, Nontunable)
  %Dither Dither control for NCO
  %   When you set this property to true, a number of dither bits specified
  %   in the NumDitherBits property will be used to apply dither to the NCO
  %   signal. This property applies when you set the Oscillator property to
  %   'NCO'. The default is true.
  %  
  %   See also dsp.NCO.  
  Dither = true;
end

properties (Dependent, Nontunable)
  %SecondFilterOrder Order of CIC compensation filter stage
  %   Set this property to a positive, integer scalar. This property applies
  %   when you set the FilterSpecification property to 'Design parameters'
  %   and the MinimumOrderDesign property to false. The default is 12.
  SecondFilterOrder
  %Bandwidth Two sided bandwidth of input signal in Hertz
  %   Set this property to a positive, integer scalar. The object sets the
  %   passband frequency of the cascade of filters to one-half of the value
  %   that you specify in the Bandwidth property. This property applies when
  %   you set the FilterSpecification property to 'Design parameters'. The
  %   default is 200e3 Hertz.
  Bandwidth
  %StopbandFrequency Stopband frequency in Hertz
  %   Set this property to a double precision positive scalar. This property
  %   applies when you set the FilterSpecification property to 'Design
  %   parameters' and the StopbandFrequencySource property to 'Property'.
  %   The default is 150e3 Hertz.
  StopbandFrequency
  %PassbandRipple Passband ripple of cascade response in dB
  %   Set this property to a double precision, positive scalar. When you set
  %   the MinimumOrderDesign property to true, the object designs the
  %   filters so that the cascade response meets the passband ripple that
  %   you specify in the PassbandRipple property. This property applies when
  %   you set the FilterSpecification property to 'Design parameters' and
  %   the MinimumOrderDesign property to true. The default is 0.1 dB.
  PassbandRipple
  %StopbandAttenuation Stopband attenuation of cascade response in dB
  %   Set this property to a double precision, positive scalar. When you set
  %   the MinimumOrderDesign property to true, the object designs the
  %   filters so that the cascade response meets the stopband attenuation
  %   that you specify in the StopbandAttenuation property. This property
  %   applies when you set the FilterSpecification property to 'Design
  %   parameters' and the MinimumOrderDesign property to true. The default
  %   is 60 dB.
  StopbandAttenuation  
end

  % Fixed-point properties

properties (Nontunable)
  % SecondFilterCoefficientsDataType Data type of second filter coefficients 
  %   Specify the second filter coefficients data type as 'Same as input'
  %   |'Custom'. The default is 'Same as input'. This property applies when
  %   you set the FilterSpecification  property to 'Coefficients'.
  SecondFilterCoefficientsDataType = 'Same as input';
  % CustomSecondFilterCoefficientsDataType Fixed-point data type of second 
  %                                        filter coefficients
  %   Specify the second filter coefficients fixed-point type as a scaled
  %   numerictype object with a Signedness of Auto. This property applies
  %   when you set the SecondFilterCoefficientsDataType property to
  %   'Custom'. The default is numerictype([],16,15).
  %
  %   See also numerictype.
  CustomSecondFilterCoefficientsDataType = numerictype([],16,15);
  % OutputDataType Data type of output
  %    Specify the data type of output as 'Same as input' | 'Custom'. The
  %    default is 'Same as input'.
  OutputDataType = 'Same as input';
  % CustomOutputDataType Fixed-point data type of output
  %   Specify the output fixed-point type as a scaled numerictype object
  %   with a Signedness of Auto. This property applies when you set the
  %   OutputDataType property to 'Custom'. The default is
  %   numerictype([],16,15).
  %
  %   See also numerictype.
  CustomOutputDataType = numerictype([],16,15);
end

properties (Access = protected)
  %pCIC CIC filter
  pCIC
  %pCICComp CIC compensator filter
  pCICComp
  %pCICNormalizationFactor Scaling factor to normalize CIC response
  pCICNormalizationFactor
  %pOscillator Oscillator for the frequency converter
  pOscillator
  %pFilterDesigner Handle of the filter designer object
  pFilterDesigner = [];
  %pInputDataType Input data type
  pInputDataType
  %pIsInputFixedPoint True if input is fixed point
  pIsInputFixedPoint
  %pArithmetic Arithmetic of filters. Can be 'double', 'single' or
  %'fixed-point'
  pArithmetic
  %pInputSize Size of input signal
  pInputSize
  %pInputNumericType If input is fixed point, this property holds the
  %numerictype of that input data.
  pInputNumericType
  %pOscillatorOutputNumericType Numeric type of oscillator output
  pOscillatorOutputNumericType
  %pInitOscillatorOutput Data initialization used to cast the oscillator
  %output.
  pInitOscillatorOutput
  %pSecondFilterCoefficientsNumericType Numeric type of second filter
  %coefficients
  pSecondFilterCoefficientsNumericType
  %pInitMixerOutput Data initialization used to cast the mixer output
  pInitMixerOutput
  %pInitCICNormOutput Data initialization used to cast CIC normalization
  %output
  pInitCICNormOutput
  %pReinterpretCastNumericType Numeric type of reinterpreted CIC output
  pReinterpretCastNumericType
  %pOutputNumericType Numeric type of output
  pOutputNumericType
  %pCastOutputToBuiltInInteger If true, then we need to cast the output to
  %a built in integer
  pCastOutputToBuiltInInteger
  %pCastOutputToFloatingFi If true then we need to cast the output to a
  %double or single fi object.
  pCastOutputToFloatingFi
  %pOutputCastFunction Handle to the output cast function
  pOutputCastFunction  
  %pRemNormFactor Remaining normalization factor
  pRemNormFactor
  %pNormalizeCICOutputFunction Handle to CIC normalization helper function
  pNormalizeCICOutputFunction
end

properties(Constant, Hidden)
  OutputDataTypeSet = matlab.system.StringSet(...
    {'Same as input','Custom'});
  SecondFilterCoefficientsDataTypeSet = matlab.system.StringSet(...
    {'Same as input','Custom'});
end

%---------------------------------------------------------------------------
% Abstract methods
%---------------------------------------------------------------------------
methods(Access = protected, Abstract)
  isEmptyFilterDesigner(obj)  
  flag = isFilterCoefficientsDataTypeSameAsInput(obj)
  checkFactorLength(obj)
  checkFactorValues(obj)
  checkFsFc(obj)
  setCustomCoefficientsDataType(obj)
end
%---------------------------------------------------------------------------
% Public methods
%---------------------------------------------------------------------------
methods
  %------------------------------------------------------------------------
  function varargout = visualizeFilterStages(obj,varargin)
    %visualizeFilterStages Display response of filter stages
    %   visualizeFilterStages(H) plots the magnitude response of the filter
    %   stages and of the cascade response. When the FilterSpecification
    %   property is set to 'Design parameters' the method plots a mask based
    %   on the filter specifications. By default, the object plots the
    %   response of the filters up to the second CIC null frequency (or to
    %   the first when only one CIC null exists).
    %
    %   visualizeFilterStages(H,'Arithmetic',ARITH) specifies the arithmetic
    %   of the filter stages. You set input ARITH to 'double', 'single', or
    %   'fixed-point'. When object H is in an unlocked state you must
    %   specify the arithmetic. When object H is in a locked state the
    %   arithmetic input is ignored.
    %
    %   hfvt = visualizeFilterStages(H) returns a handle to an FVTool
    %   object.
       
    inputArith = parseArithmetic(obj,varargin{:});    
    
    % Check if filters have been designed for the specified arithmetic. If
    % no designs are available, design the filters.
    designFilters(obj,inputArith)
    
    hfvt = callPlotMethod(obj,'visualizeFilterStages');
    if nargout == 1
      varargout{1} = hfvt;
    elseif nargout > 1
      error(message('dsp:system:DigitalConverterBase_FvtoolTooManyArguments'));
    end
  end
  %------------------------------------------------------------------------
  function varargout = fvtool(obj,varargin)
    %fvtool Visualize response of filter cascade
    %   fvtool(H) plots the magnitude response of the cascade of filters. By
    %   default, the object plots the cascade response up to the second CIC
    %   null frequency (or to the first when only one CIC null exists). When
    %   the FilterSpecification property is set to 'Design parameters' the
    %   method plots a mask based on the filter specifications.
    %    
    %   fvtool(H,..,'Arithmetic',ARITH,...) specifies the arithmetic of the
    %   filter cascade. You set input ARITH to 'double', 'single', or
    %   'fixed-point'. When object H is in an unlocked state you must
    %   specify the arithmetic. When object H is in a locked state the
    %   arithmetic input is ignored.
    %
    %   fvtool(H,..., PROP1, VALUE1,PROP2,VALUE2, etc.) launches FVTool and
    %   sets the specified FVTool properties to the specified values.
    %
    %  See also visualizeFilterStages.
    
    if isempty(varargin)
      inputArith = [];
    else
      inputArith = [];
      idx = strcmp('Arithmetic',varargin);      
      if any(idx)
         idxCell = find(idx == 1);
         inputArith = varargin{idxCell+1};
         
         if ~any(strcmpi(inputArith,{'double','single','fixed-point'}))
           error(message('dsp:system:DigitalConverterBase_FvtoolInvalidArithmetic'));
         end
         
         if strcmpi(inputArith,'fixed-point')
           inputArith = 'fixed';
         end                           
         
         varargin([idxCell idxCell+1]) = [];                           
      end            
    end    
    
    % Check if filters have been designed for the specified arithmetic. If
    % no designs are available, design the filters.
    designFilters(obj,inputArith)
    
    hfvt = callPlotMethod(obj,'fvtool',varargin{:});
    if nargout == 1
      varargout{1} = hfvt;
    elseif nargout > 1
      error(message('dsp:system:DigitalConverterBase_FvtoolTooManyArguments'));
    end  
  end
  %-----------------------------------------------------------------------
  function [d,f] = groupDelay(obj,varargin)
    %groupDelay Group delay of filter cascade
    %   D = groupDelay(H,N) returns a vector of group delays, D, evaluated
    %   at N frequency points equally spaced around the upper half of the
    %   unit circle. If you don't specify N, it defaults to 8192.
    %
    %   [D,F] = groupDelay(H,N) returns a vector of frequencies at which
    %   the group delay has been computed.
    
    % If no design is available, design filters using double arithmetic.
    if ~(obj.pFilterDesigner.FilterDesignIsAvailable) 
      obj.pFilterDesigner.Arithmetic = 'double';
      design(obj.pFilterDesigner);
    end    
    [d,f] = groupDelay(obj.pFilterDesigner,varargin{:});
  end
  %-----------------------------------------------------------------------
  % Set/Get methods
  %------------------------------------------------------------------------
  %SecondFilterOrder
  function set.SecondFilterOrder(obj,val)
    validateattributes(val, ...
      {'double'},{'scalar','positive','integer'}, '', 'SecondFilterOrder');
    
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.OrderStage2 = val;
  end
  
  function val = get.SecondFilterOrder(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.OrderStage2;
  end  
  %---------------------------------------------
  %Bandwidth
  function set.Bandwidth(obj,val)
    validateattributes(val, ...
      {'double'},{'scalar','positive','real'}, '', 'Bandwidth');
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.Bandwidth = val;
  end
  
  function val = get.Bandwidth(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.Bandwidth;
  end
  %---------------------------------------------
  %StopbandFrequency
  function set.StopbandFrequency(obj,val)
    validateattributes(val, ...
      {'double'},{'scalar','positive','real'}, '', 'StopbandFrequency');
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.StopbandFrequency = val;
  end
  
  function val = get.StopbandFrequency(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.StopbandFrequency;
  end  
  %---------------------------------------------
  %PassbandRipple
  function set.PassbandRipple(obj,val)
    validateattributes(val, ...
      {'double'},{'scalar','positive','real'}, '', 'PassbandRipple');
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.PassbandRipple = val;
  end
  
  function val = get.PassbandRipple(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.PassbandRipple;
  end
  %---------------------------------------------
  %StopbandAttenuation
  function set.StopbandAttenuation(obj,val)
    validateattributes(val, ...
      {'double'},{'scalar','positive','real'}, '', 'StopbandAttenuation');
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.StopbandAttenuation = val;
  end
  
  function val = get.StopbandAttenuation(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.StopbandAttenuation;
  end
  %---------------------------------------------
  %NumAccumulatorBits
  function set.NumAccumulatorBits(obj,val)
    validateattributes(val, ...
      {'double'},{'scalar','positive','integer'}, '', 'NumAccumulatorBits');
    obj.NumAccumulatorBits = val;
  end
  %---------------------------------------------
  %NumQuantizedAccumulatorBits
  function set.NumQuantizedAccumulatorBits(obj,val)
    validateattributes(val, {'double'}, ...
      {'scalar','positive','integer'}, '', 'NumQuantizedAccumulatorBits');
    obj.NumQuantizedAccumulatorBits = val;
  end
  %---------------------------------------------
  %NumDitherBits
  function set.NumDitherBits(obj,val)
    validateattributes(val, ...
      {'double'},{'scalar','positive','integer'}, '', 'NumDitherBits');
    obj.NumDitherBits = val;
  end    
  %---------------------------------------------
  % Fixed point properties
  %---------------------------------------------
  function set.CustomSecondFilterCoefficientsDataType(obj,val)
    validateCustomDataType(obj,'CustomSecondFilterCoefficientsDataType',val, ...
      {'AUTOSIGNED','SCALED'});
    obj.CustomSecondFilterCoefficientsDataType = val;
  end    
  function set.CustomOutputDataType(obj,val)
    validateCustomDataType(obj,'CustomOutputDataType',val, ...
      {'AUTOSIGNED','SCALED'});
    obj.CustomOutputDataType = val;    
  end  
end
%---------------------------------------------------------------------------
% Protected methods
%---------------------------------------------------------------------------
methods (Access = protected)
  function obj = DigitalConverterBase(varargin)
    setProperties(obj, nargin, varargin{:});
  end
  %------------------------------------------------------------------------
  function num = getNumOutputsImpl(~)
    num = 1;
  end
  %------------------------------------------------------------------------  
  function flag = isInputSizeLockedImpl(~,~)
     flag = true;
  end
  %------------------------------------------------------------------------  
  function flag = isInputComplexityLockedImpl(~,~)
     flag = true;
   end
  %------------------------------------------------------------------------  
  function flag = isOutputComplexityLockedImpl(~,~)
    flag = true;
  end
  %------------------------------------------------------------------------
  function validatePropertiesImpl(obj)
        
    if strcmp(obj.FilterSpecification,'Coefficients') 
      % Decimation or Interpolation factors must be vectors in this case
       checkFactorLength(obj);                  
    end
    checkFactorValues(obj);
    
    % Check that sample rate at oscillator input is at least twice the
    % oscillator frequency
    checkFsFc(obj);
    
    if  strcmp(obj.Oscillator,'NCO')
      if obj.NumQuantizedAccumulatorBits > obj.NumAccumulatorBits
        error(message('dsp:system:DigitalConverterBase_invalidNumAccumBits'));
      end
      
      if obj.NumDitherBits > obj.NumAccumulatorBits
        error(message('dsp:system:DigitalConverterBase_invalidNumAccumBits1'));
      end
    end
  end  
  %------------------------------------------------------------------------
  function setInputOutputTypes(obj,x)
    % Cache data types of inputs and outputs
    
    obj.pCastOutputToFloatingFi = false;
    obj.pCastOutputToBuiltInInteger = false;
     
    if any(strcmp(obj.pInputDataType,{'uint8','uint16','uint32'}))
      error(message('dsp:system:DigitalConverterBase_invalidInputDataType'));
    elseif strcmp(obj.pInputDataType, 'embedded.fi')
      if ~strcmp(x.Signedness,'Signed')
        error(message('dsp:system:DigitalConverterBase_invalidInputDataSignedness'));
      end      
      nt = numerictype(true,x.WordLength,x.FractionLength);
      obj.pInputNumericType = nt;
      obj.pIsInputFixedPoint = true;
    elseif any(strcmp(obj.pInputDataType,{'int8','int16','int32'}))
      obj.pInputNumericType = ...
        numerictype(true,str2double(obj.pInputDataType(4:end)),0);
      obj.pIsInputFixedPoint = true;
      if strcmp(obj.OutputDataType,'Same as input')
        obj.pCastOutputToBuiltInInteger = true;
      end
    else % input data type is double or single
      obj.pIsInputFixedPoint = false;
      if isa(x,'embedded.fi')
        obj.pCastOutputToFloatingFi = true;
        if isdouble(x)
          nt = numerictype('DataType','double');
        elseif issingle(x)
          nt = numerictype('DataType','single');
        end
        obj.pInputNumericType = nt;
      end
    end          
    
    if obj.pIsInputFixedPoint
      obj.pArithmetic = 'fixed';
      % Set the numeric type of the output
      if strcmp(obj.OutputDataType,'Same as input')
        obj.pOutputNumericType = numerictype([],...
          obj.pInputNumericType.WordLength,...
          obj.pInputNumericType.FractionLength);
      else
        obj.pOutputNumericType = numerictype([],...
          obj.CustomOutputDataType.WordLength,...
          obj.CustomOutputDataType.FractionLength);
      end
      
      if strcmp(obj.FilterSpecification,'Coefficients')        
        if strcmp(obj.SecondFilterCoefficientsDataType,'Same as input')
          obj.pSecondFilterCoefficientsNumericType = numerictype([],...
            obj.pInputNumericType.WordLength,...
            obj.pInputNumericType.FractionLength);
        else
          obj.pSecondFilterCoefficientsNumericType = numerictype([],...
            obj.CustomSecondFilterCoefficientsDataType.WordLength,...
            obj.CustomSecondFilterCoefficientsDataType.FractionLength);
        end
      end
    else
      obj.pArithmetic = obj.pInputDataType;
    end        
  end
  %-------------------------------------------------------------------------
  function designOscillator(obj,frameLength,sampleRate)   
    % Design a sine wave generator or an NCO
    
    if strcmp(obj.Oscillator,'Sine wave')
      obj.pOscillator = dsp.SineWave(...
        'Frequency', obj.CenterFrequency,...
        'SampleRate', sampleRate,...
        'ComplexOutput', true,...
        'SamplesPerFrame',frameLength);
    elseif strcmp(obj.Oscillator,'NCO')
      Ts = 1/sampleRate;
      phaseInc = round(obj.CenterFrequency*(2^obj.NumAccumulatorBits)*Ts);
      obj.pOscillator = dsp.NCO(...
        'PhaseIncrementSource','Property',...
        'PhaseIncrement',phaseInc,...
        'NumQuantizerAccumulatorBits',obj.NumQuantizedAccumulatorBits,...
        'AccumulatorDataType', 'Custom',...
        'CustomAccumulatorDataType',numerictype([],obj.NumAccumulatorBits),...
        'Dither',obj.Dither,...
        'SamplesPerFrame',frameLength,...
        'Waveform','Complex exponential');
      if obj.Dither
        obj.pOscillator.NumDitherBits = obj.NumDitherBits;
      end
    end
    
    % If input X is fixed point with word length WLX, then set the
    % oscillator output data type to have a word length of WLX+1 and a
    % fraction length of WLX+1-2.
    if obj.pIsInputFixedPoint
      if strcmp(obj.Oscillator,'NCO')
      obj.pOscillator.OutputDataType = 'Custom';  
      obj.pOscillator.CustomOutputDataType = ...
        obj.pOscillatorOutputNumericType;
      end
    else % double or single
      obj.pOscillator.OutputDataType = obj.pInputDataType;
    end
  end   
  %------------------------------------------------------------------------
  function designFilters(obj,inputArith)
    % Check the validity of inputArith and then design filters if a design
    % is not available or if the filters must be redesigned for a different
    % arithmetic.    
    if ~isLocked(obj)
      if isempty(inputArith)
        % The arithmetic was not specified and the object is not locked
        error(message('dsp:system:DigitalConverterBase_methodLacksArithmetic'));
      end
      
      if strcmp(obj.FilterSpecification,'Coefficients') && ...          
          strcmpi(inputArith,'fixed')        
        if isFilterCoefficientsDataTypeSameAsInput(obj)
          error(message('dsp:system:DigitalConverterBase_methodUnknownInputDataType'));
        else
          % Set the coefficients data type of the designer object to the
          % custom data types specified by the user
          setCustomCoefficientsDataType(obj)
        end
      end
      % Design filters if they are not available for the arithmetic of
      % interest.
      if ~(obj.pFilterDesigner.FilterDesignIsAvailable && ...
          strcmp(obj.pFilterDesigner.Arithmetic,inputArith))
        obj.pFilterDesigner.Arithmetic = inputArith;
        design(obj.pFilterDesigner);
      end
    else
      if ~isempty(inputArith) && ...
          ~strcmp(obj.pFilterDesigner.Arithmetic,inputArith)
        % The arithmetic has been specified but the object is locked
        warning(message('dsp:system:DigitalConverterBase_methodIgnoresArithmetic'));
      end
    end
  end
  %------------------------------------------------------------------------  
  function hfvt = callPlotMethod(obj,plotMethod,varargin)
  % Call either fvtool or visualizeFilterStages of the filter designer
  % object. The plotMethod input can be 'fvtool' or 'visualizeFilterStages'.
  % Input varargin contains other arguments that can be passed to fvtool.
    if strcmp(plotMethod,'fvtool')
      hfvt = fvtool(obj.pFilterDesigner,varargin{:});
    else
      hfvt = visualizeFilterStages(obj.pFilterDesigner);
    end    
  end  
  %------------------------------------------------------------------------
  function inputArith = parseArithmetic(~,varargin)
    % Parse arithmetic input
    if length(varargin) > 2
      error(message('dsp:system:DigitalConverterBase_arithmeticTooManyInputs'));
    end
    
    if isempty(varargin)
      inputArith = [];
    elseif length(varargin) == 1
      error(message('dsp:system:DigitalConverterBase_arithmeticNotValidPVPair'));
    else
      
      if ~strcmpi(varargin{1},'arithmetic')
        error(message('dsp:system:DigitalConverterBase_arithmeticNotValidParamName'));
      end
      
      if ~strcmpi(varargin{2},{'double','single','fixed-point'})
        error(message('dsp:system:DigitalConverterBase_arithmeticInvalidArithmetic'));
      end
      
      inputArith = varargin{2};
      if strcmpi(inputArith,'fixed-point')
        inputArith = 'fixed';
      end
    end    
  end
  
  function s = saveObjectImpl(obj)
      s = saveObjectImpl@matlab.System(obj);
      if isLocked(obj)
          s.pCIC        = matlab.System.saveObject(obj.pCIC);
          s.pCICComp    = matlab.System.saveObject(obj.pCICComp);
          s.pOscillator = matlab.System.saveObject(obj.pOscillator);
          s.pCICNormalizationFactor = obj.pCICNormalizationFactor;
          s.pFilterDesigner = obj.pFilterDesigner;
          s.pInputDataType = obj.pInputDataType;
          s.pIsInputFixedPoint = obj.pIsInputFixedPoint;
          s.pArithmetic = obj.pArithmetic;
          s.pInputSize = obj.pInputSize;
          s.pInputNumericType = obj.pInputNumericType;
          s.pOscillatorOutputNumericType = obj.pOscillatorOutputNumericType;
          s.pInitOscillatorOutput = obj.pInitOscillatorOutput;
          s.pSecondFilterCoefficientsNumericType = obj.pSecondFilterCoefficientsNumericType;
          s.pInitMixerOutput = obj.pInitMixerOutput;
          s.pInitCICNormOutput = obj.pInitCICNormOutput;
          s.pReinterpretCastNumericType = obj.pReinterpretCastNumericType;
          s.pOutputNumericType = obj.pOutputNumericType;
          s.pCastOutputToBuiltInInteger = obj.pCastOutputToBuiltInInteger;
          s.pCastOutputToFloatingFi = obj.pCastOutputToFloatingFi;
          s.pOutputCastFunction = obj.pOutputCastFunction;
          s.pRemNormFactor = obj.pRemNormFactor;
          s.pNormalizeCICOutputFunction = obj.pNormalizeCICOutputFunction;
      end
  end
  
  %------------------------------------------------------------------------
  function loadSubObjects(obj,s,wasLocked)
      if wasLocked
          obj.pOscillator     =  matlab.System.loadObject(s.pOscillator);
          obj.pCIC            =  matlab.System.loadObject(s.pCIC);
          obj.pCICComp        =  matlab.System.loadObject(s.pCICComp);
          obj.pCICNormalizationFactor = s.pCICNormalizationFactor;
          obj.pFilterDesigner = s.pFilterDesigner;
          obj.pInputDataType = s.pInputDataType;
          obj.pIsInputFixedPoint = s.pIsInputFixedPoint;
          obj.pArithmetic = s.pArithmetic;
          obj.pInputSize = s.pInputSize;
          obj.pInputNumericType = s.pInputNumericType;
          obj.pOscillatorOutputNumericType = s.pOscillatorOutputNumericType;
          obj.pInitOscillatorOutput = s.pInitOscillatorOutput;
          obj.pSecondFilterCoefficientsNumericType = s.pSecondFilterCoefficientsNumericType;
          obj.pInitMixerOutput = s.pInitMixerOutput;
          obj.pInitCICNormOutput = s.pInitCICNormOutput;
          obj.pReinterpretCastNumericType = s.pReinterpretCastNumericType;
          obj.pOutputNumericType = s.pOutputNumericType;
          obj.pCastOutputToBuiltInInteger = s.pCastOutputToBuiltInInteger;
          obj.pCastOutputToFloatingFi = s.pCastOutputToFloatingFi;
          obj.pOutputCastFunction = s.pOutputCastFunction;
          obj.pRemNormFactor = s.pRemNormFactor;
          obj.pNormalizeCICOutputFunction = s.pNormalizeCICOutputFunction;
      end
  end
  %------------------------------------------------------------------------
  function dataType = getInputType(~,x)
    dataType = class(x);
    if isa(x,'embedded.fi')
      % Check if data is not fi double or fi single
      if isdouble(x)
        dataType = 'double';
      elseif issingle(x)
        dataType = 'single';
      end
    end
  end
end
end

