classdef DigitalDownConverter < dsp.private.DigitalConverterBase
%DigitalDownConverter Digitally down convert input signal
%   H = dsp.DigitalDownConverter creates a digital down converter (DDC)
%   System object, H. The object frequency down converts the input signal
%   by multiplying it with a complex exponential with center frequency
%   equal to the value in the CenterFrequency property. The object down
%   samples the frequency down converted signal using a cascade of three
%   decimation filters. When you set the FilterSpecification property to
%   'Design parameters', the DDC object designs the decimation filters
%   according to the filter parameters that you set in the filter-related
%   object properties. In this case the filter cascade consists of a CIC
%   decimator, a CIC compensator and a third FIR decimation stage that can
%   be bypassed depending on how you set the properties of the DDC object.
%
%   H = dsp.DigitalDownConverter(Name,Value) creates a DDC object, H, with
%   the specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) takes a real or complex input column vector X and outputs
%   a frequency down converted and down sampled signal Y. The length of
%   input X must be a multiple of the decimation factor. X can be of data
%   type double, single, signed integer, or signed fixed point (fi
%   objects). The length of Y is equal to the length of X divided by the
%   DecimationFactor. When the data type of X is double or single
%   precision, the data type of Y is the same as that of X. When the data
%   type of X is of a fixed point type, the data type of Y is defined by
%   the OutputDataType property.
%
%   Y = step(H,X,Z) uses the complex input, Z, as the oscillator signal
%   used to frequency down convert input X, when you set the Oscillator
%   property to 'Input port'. The length of Z must be equal to the number
%   of rows of X. Z can be of data type double, single, signed integer, or
%   signed fixed point (fi objects).
%
%   DigitalDownConverter methods:
%
%   step                  - Digitally down convert input signal (see above)
%   release               - Allow property value and input characteristics
%                           changes
%   clone                 - Create DDC object with same property values
%   isLocked              - Locked status (logical)
%   getDecimationFactors  - Get decimation factors of each filter stage
%   getFilters            - Get handles to decimation filter objects
%   getFilterOrders       - Get orders of decimation filters
%   visualizeFilterStages - Visualize response of each filter stage
%   fvtool                - Visualize response of the filter cascade
%   groupDelay            - Compute the group delay of the filter cascade
%
%   DigitalDownConverter properties:
%   
%   SampleRate                  - Sample rate of input signal
%   DecimationFactor            - Decimation factor
%   FilterSpecification         - Filter specification
%   MinimumOrderDesign          - Minimum order filter design
%   NumCICSections              - Number of sections of CIC decimator
%   SecondFilterCoefficients    - Coefficients of second filter stage
%   ThirdFilterCoefficients     - Coefficients of third filter stage
%   SecondFilterOrder           - Order of CIC compensation filter stage
%   ThirdFilterOrder            - Order of third filter stage
%   Bandwidth                   - Two sided bandwidth of input signal in Hertz
%   StopbandFrequencySource     - Source of stopband frequency
%   StopbandFrequency           - Stopband frequency in Hertz
%   PassbandRipple              - Passband ripple of cascade response in dB
%   StopbandAttenuation         - Stopband attenuation of cascade response in dB
%   Oscillator                  - Type of oscillator
%   CenterFrequency             - Center frequency of input signal in Hertz
%   NumAccumulatorBits          - Number of NCO accumulator bits
%   NumQuantizedAccumulatorBits - Number of NCO quantized accumulator bits
%   Dither                      - Dither control for NCO
%   NumDitherBits               - Number of NCO dither bits
%
%   The DigitalDownConverter object supports fixed-point operations. For
%   more information, type dsp.DigitalDownConverter.helpFixedPoint.
%
%   % Example:
%   %   Create a digital up converter object that up samples a 1 KHz 
%   %   sinusoidal signal by a factor of 20 and up converts it to 50 KHz. 
%   %   Create a digital down converter object that down converts the signal
%   %   to 0 Hz and down samples it by a factor of 20.
% 
%   % Create a sine wave generator to obtain the 1 KHz sinusoidal signal
%   % with a sample rate of 6 KHz.
%   Fs = 6e3; % Sample rate
%   hSig = dsp.SineWave('Frequency',1000,'SampleRate', Fs,'SamplesPerFrame',1024);
%   x = step(hSig); % generate signal
% 
%   % Create a DUC object. Use minimum order filter designs and set the
%   % passband ripple to 0.2 dB and the stopband attenuation to 55 dB. Set
%   % the double sided signal bandwidth to 2 KHz. 
%   hDUC = dsp.DigitalUpConverter(... 
%    'InterpolationFactor', 20,...
%    'SampleRate', Fs,...
%    'Bandwidth', 2e3,...
%    'StopbandAttenuation', 55,...
%    'PassbandRipple',0.2,...
%    'CenterFrequency',50e3);
% 
%   % Create a DDC object. Use minimum order filter designs and set the
%   % passband ripple to 0.2 dB and the stopband attenuation to 55 dB.
%   hDDC = dsp.DigitalDownConverter(...
%     'DecimationFactor',20,...
%     'SampleRate', Fs*20,...
%     'Bandwidth', 3e3,...
%     'StopbandAttenuation', 55,...
%     'PassbandRipple',0.2,...
%     'CenterFrequency',50e3);
%  
%   % Create a spectrum estimator to visualize the signal spectrum before up
%   % converting, after up converting, and after down converting.
%   window = hamming(floor(length(x)/10));
%   figure; pwelch(x,window,[],[],Fs,'centered')
%   title('Spectrum of baseband signal x')
% 
%   % Up convert the signal and visualize the spectrum
%   xUp = step(hDUC,x); % up convert
%   window = hamming(floor(length(xUp)/10));
%   figure; pwelch(xUp,window,[],[],20*Fs,'centered');
%   title('Spectrum of up converted signal xUp')
% 
%   % Down convert the signal and visualize the spectrum
%   xDown = step(hDDC,xUp); % down convert
%   window = hamming(floor(length(xDown)/10));
%   figure; pwelch(xDown,window,[],[],Fs,'centered');
%   title('Spectrum of down converted signal xDown')
% 
%   % Visualize the response of the decimation filters
%   visualizeFilterStages(hDDC)
%
%   See also dsp.DigitalUpConverter, dsp.SineWave, dsp.NCO,
%   dsp.CICDecimator, dsp.FIRDecimator.

%   Copyright 2010-2013 The MathWorks, Inc.

properties (Nontunable)
  %Oscillator Type of oscillator
  %   Specify the oscillator as one of 'Sine wave' | 'NCO' | 'Input port' |
  %   'None'. The default is 'Sine wave'. When you set this property to
  %   'Sine wave', the object frequency down converts the input signal
  %   using a complex exponential obtained from samples of a sinusoidal
  %   trigonometric function. When you set this property to 'NCO' the
  %   object performs frequency down conversion with a complex exponential
  %   obtained using a numerically controlled oscillator (NCO). When you
  %   set this property to 'Input port', the object performs frequency down
  %   conversion using the complex signal that you set as an input to the
  %   step method. When you set this property to 'None' the object performs
  %   down sampling but no frequency down conversion.
  Oscillator = 'Sine wave'  
  %CenterFrequency Center frequency of input signal in Hertz
  %   Specify this property as a double precision scalar. The object down
  %   converts the input signal from the passband center frequency you
  %   specify in the CenterFrequency property, to 0 Hertz. This property
  %   applies when you set the Oscillator property to 'Sine wave' or 'NCO'.
  %   The default is 14e6 Hertz.
  CenterFrequency = 14e6;  
end

properties (Dependent, Nontunable)
  %SampleRate Sample rate of input signal
  %   Set this property to a positive scalar. The default is 30e6 Hertz.
  SampleRate    
  %DecimationFactor Decimation factor
  %   Set this property to a positive, integer scalar, or to a 1x2 or 1x3
  %   vector of positive integers.
  %   
  %   When you set this property to a scalar the object automatically
  %   chooses the decimation factors for each of the three filtering stages.
  %   The scalar value you specify cannot be a prime number.
  %   
  %   When you set this property to a 1x2 vector, the object bypasses the
  %   third filter stage and sets the decimation factor of the first and
  %   second filtering stages to the values in the first and second vector
  %   elements respectively. When you set the FilterSpecification property
  %   to 'Design parameters', both elements of the DecimationFactor vector
  %   must be greater than one. When you set the FilterSpecification
  %   property to 'Coefficients', the first element of the DecimationFactor
  %   vector must be greater than 1.
  %   
  %   When you set this property to a 1x3 vector, the i-th element of the
  %   vector specifies the decimation factor for the i-th filtering stage.
  %   When you set the FilterSpecification property to 'Design parameters',
  %   the first and second elements of the DecimationFactor vector must be
  %   greater than one and the third element must be 1 or 2. When you set
  %   the FilterSpecification property to 'Coefficients', the first element
  %   of the DecimationFactor vector must be greater than 1.
  %
  %   When you set the FilterSpecification property to 'Coefficients', you
  %   must set the DecimationFactor property to a 1x3 or 1x2 vector.
  %
  %   The default is 100.
  DecimationFactor
  %FilterSpecification Filter specification
  %   Set the filter specification as one of 'Design parameters' |
  %   'Coefficients'. The default is 'Design parameters'. The DDC object
  %   performs decimation using a cascade of three decimation filters. The
  %   first filter stage is always a CIC decimator. When you set the
  %   FilterSpecification property to 'Design parameters', the object
  %   designs the cascade of decimation filters internally, according to a
  %   set of parameters that you specify using the filter-related object
  %   properties. In this case, the second and third stages of the cascade
  %   consist of a CIC compensator, and a halfband or lowpass FIR decimator
  %   respectively. When you set the FilterSpecification property to
  %   'Coefficients', you specify an arbitrary set of filter coefficients
  %   for the second and third filter stages using the
  %   SecondFilterCoefficients, and ThirdFilterCoefficients properties
  %   respectively. You specify the number of CIC sections using the
  %   NumCICSections property. In all cases, the third filter stage can be
  %   bypassed by setting the DecimationFactor property appropriately.
  %
  %   When the input data type is double or single the object implements an
  %   N-section CIC decimation filter as an FIR filter with a response that
  %   corresponds to a cascade of N boxcar filters. A true CIC filter with
  %   actual comb and integrator sections is implemented when the input
  %   data is of a fixed point type.
  FilterSpecification  
  %NumCICSections Number of sections of CIC decimator
  %   Set this property to a positive, integer scalar. This property applies
  %   when you set the FilterSpecification property to 'Design parameters'
  %   and the MinimumOrderDesign property to false, or when you set the
  %   FilterSpecification property to 'Coefficients'. The default is 3.
  NumCICSections  
  %SecondFilterCoefficients Coefficients of second filter stage
  %   Set this property to a double precision row vector of real
  %   coefficients that correspond to an FIR filter. Usually, the response
  %   of this filter should be that of a CIC compensator since a CIC
  %   decimation filter precedes the second filter stage. This property
  %   applies when you set the FilterSpecification property to
  %   'Coefficients'. The default is 1.
  SecondFilterCoefficients    
  %ThirdFilterCoefficients Coefficients of third filter stage
  %   Set this property to a double precision row vector of real
  %   coefficients that correspond to an FIR filter. When you set the
  %   DecimationFactor property to a 1x2 vector, the object ignores the
  %   value of the ThirdFilterCoefficients property because the third filter
  %   stage is bypassed. This property applies when you set the
  %   FilterSpecification property to 'Coefficients'. The default is 1.
  ThirdFilterCoefficients  
  %ThirdFilterOrder Order of third filter stage
  %   Set this property to a positive, integer, even scalar. When you set
  %   the DecimationFactor property to a 1x2 vector, the object ignores the
  %   ThirdFilterOrder property because the third filter stage is bypassed.
  %   This property applies when you set the FilterSpecification property to
  %   'Design parameters' and the MinimumOrderDesign property to false. The
  %   default is 10.
  ThirdFilterOrder
  %StopbandFrequencySource Source of stopband frequency
  %   Specify the source of the stopband frequency as one of 'Auto' |
  %   'Property'. The default is 'Auto'. When you set this property to
  %   'Auto', the object places the cutoff frequency of the cascade filter
  %   response at approximately Fc = SampleRate/M/2 Hertz, where M is the
  %   total decimation factor that you specify in the DecimationFactor
  %   property. The object computes the stopband frequency as Fstop = Fc +
  %   TW/2. TW is the transition bandwidth of the cascade response computed
  %   as 2*(Fc-Fp), and the passband frequency, Fp, equals Bandwidth/2. This
  %   property applies when you set the FilterSpecification property to
  %   'Design parameters'.
  StopbandFrequencySource
end

properties (Nontunable, Logical)
  %MinimumOrderDesign Minimum order filter design
  %   When you set this property to true the object designs filters with the
  %   minimum order that meets the passband ripple, stopband attenuation,
  %   passband frequency, and stopband frequency specifications that you set
  %   using the PassbandRipple, StopbandAttenuation, Bandwidth,
  %   StopbandFrequencySource, and StopbandFrequency properties. When you
  %   set this property to false, the object designs filters with orders
  %   that you specify in the NumCICSections, SecondFilterOrder, and
  %   ThirdFilterOrder properties. The filter designs meet the passband and
  %   stopband frequency specifications that you set using the Bandwidth,
  %   StopbandFrequencySource, and StopbandFrequency properties. This
  %   property applies when you set the FilterSpecification property to
  %   'Design parameters'. The default is true.
  MinimumOrderDesign = true;
end

  % Fixed-point properties

properties (Nontunable)
  % ThirdFilterCoefficientsDataType Data type of third filter coefficients 
  %   Specify the third filter coefficients data type as 'Same as input'
  %   |'Custom'. The default is 'Same as input'. This property applies when
  %   you set the FilterSpecification  property to 'Coefficients'.
  ThirdFilterCoefficientsDataType = 'Same as input';
  % CustomThirdFilterCoefficientsDataType Fixed-point data type of third 
  %                                       filter coefficients
  %   Specify the third filter coefficients fixed-point type as a scaled
  %   numerictype object with a Signedness of Auto. This property applies
  %   when you set the ThirdFilterCoefficientsDataType property to 'Custom'.
  %   The default is numerictype([],16,15).
  % 
  %   See also numerictype.
  CustomThirdFilterCoefficientsDataType = numerictype([], 16, 15);
  %FiltersInputDataType Data type of input of each filter stage
  %   Specify the data type at the input of the first, second, and third (if
  %   it has not been bypassed) filter stages as one of 'Same as input' |
  %   'Custom'. The default is 'Same as input'. The object casts the data at
  %   the input of each filter stage according to the value you set in this
  %   property.
  FiltersInputDataType = 'Same as input';
  %CustomFiltersInputDataType Fixed-point data type of input of each filter stage
  %   Specify the filters input fixed-point type as a scaled numerictype
  %   object with a Signedness of Auto. This property applies when you set
  %   the FiltersInputDataType property to 'Custom'. The default is
  %   numerictype([],16,15).
  % 
  %   See also numerictype.
  CustomFiltersInputDataType = numerictype([], 16, 15);
end

properties (Access = private)
  %pStage3 Handle to the third stage filter
  pStage3
  %pFiltersInputNumericType Numeric type of input to each filter stage
  pFiltersInputNumericType 
  %pThirdFilterCoefficientsNumericType Numeric type of third filter
  %coefficients
  pThirdFilterCoefficientsNumericType
  %pOscillatorFunction Handle to the oscillator helper function
  pOscillatorFunction
  %pMixerFunction Handle to the mixer helper function
  pMixerFunction
  %pThirdStageFilterFunction Handle to third stage filter helper function
  pThirdStageFilterFunction
  %pInput2DataType Data type of oscillator input
  pInput2DataType 
  %pInput2NumericType Numeric type of oscillator input
  pInput2NumericType
end

properties(Constant, Hidden)
  FilterSpecificationSet  = matlab.system.StringSet( ...
    {'Design parameters', 'Coefficients'});  
  StopbandFrequencySourceSet = dsp.CommonSets.getSet(...
    'AutoOrProperty');  
  FiltersInputDataTypeSet = matlab.system.StringSet(...
    {'Same as input','Custom'});  
  ThirdFilterCoefficientsDataTypeSet = matlab.system.StringSet(...
    {'Same as input','Custom'});
  OscillatorSet = matlab.system.StringSet(...
    {'Sine wave','NCO','Input port','None'});
end
%---------------------------------------------------------------------------
% Public methods
%---------------------------------------------------------------------------
methods
  function obj = DigitalDownConverter(varargin)    
     obj@dsp.private.DigitalConverterBase(varargin{:})    
     isEmptyFilterDesigner(obj)
  end 
  %------------------------------------------------------------------------
  function outputStruct = getFilters(obj,varargin)
    %getFilters Get handles to decimation filter objects
    %   S = getFilters(H) returns a structure, S, with copies of the filter
    %   System objects and the CIC normalization factor that form the
    %   decimation filter cascade. The ThirdFilterStage structure field
    %   will be empty if the third filter stage has been bypassed. The CIC
    %   normalization factor is equal to the inverse of the CIC filter
    %   gain. In some cases this gain will have a correction factor to
    %   ensure that the cascade response meets the ripple specifications.
    %
    %   getFilters(H,'Arithmetic',ARITH) specifies the arithmetic of the
    %   filter stages. You set input ARITH to 'double', 'single', or
    %   'fixed-point'. When object H is in an unlocked state you must
    %   specify the arithmetic. When object H is in a locked state the
    %   arithmetic input is ignored.
    %
    %   See also visualizeFilterStages, dsp.DigitalDownConverter.fvtool,
    %   groupDelay, getFilterOrders, getDecimationFactors.
    
    inputArith = parseArithmetic(obj,varargin{:});    
    
    % Check if filters have been designed for the specified arithmetic. If
    % no designs are available, design the filters.
    designFilters(obj,inputArith)
    c = getFilters(obj.pFilterDesigner);    
    if isLocked(obj)    
      outputStruct.CICDecimator = clone(obj.pCIC);
      outputStruct.CICNormalizationFactor = c{4};
      outputStruct.SecondFilterStage = clone(obj.pCICComp);
      if ~isempty(c{3})
        outputStruct.ThirdFilterStage = clone(obj.pStage3);                                    
      else
        outputStruct.ThirdFilterStage = [];
      end     
    else
      outputStruct.CICDecimator = c{1};
      outputStruct.CICNormalizationFactor = c{4};
      outputStruct.SecondFilterStage = c{2};
      outputStruct.ThirdFilterStage = c{3};              
    end
  end
  %------------------------------------------------------------------------
  function outputStruct = getFilterOrders(obj,varargin)
    %getFilterOrders Get orders of decimation filters
    %   S = getFilterOrders(H) returns a structure, S, that contains the
    %   orders of the decimation filter stages. The ThirdFilterOrder
    %   structure field will be empty if the third filter stage has been
    %   bypassed.
    %
    %   See also visualizeFilterStages, dsp.DigitalDownConverter.fvtool,
    %   groupDelay, getFilters, getDecimationFactors.

    % If no design is available, design filters using double arithmetic.
    if ~(obj.pFilterDesigner.FilterDesignIsAvailable) 
      obj.pFilterDesigner.Arithmetic = 'double';
      design(obj.pFilterDesigner);
    end
        
    c = getFilters(obj.pFilterDesigner);
    decimFactors = getDecimationFactors(obj);
    if strcmpi(obj.pFilterDesigner.Arithmetic, 'fixed');
      outputStruct.NumCICSections = c{1}.NumSections;
    else
      outputStruct.NumCICSections = ...
        (length(c{1}.Numerator)-1)/(decimFactors(1)-1);
    end
    outputStruct.SecondFilterOrder = length(c{2}.Numerator)-1;
    if ~isempty(c{3})
      outputStruct.ThirdFilterOrder = length(c{3}.Numerator)-1;
    else
      outputStruct.ThirdFilterOrder = [];
    end
  end    
  %------------------------------------------------------------------------
  function M = getDecimationFactors(obj)
    %getDecimationFactors Get decimation factors of each filter stage
    %   M = getDecimationFactors(H) returns a vector, M, with the
    %   decimation factors of each filter stage. If the third filter stage
    %   is bypassed, then M is a 1x2 vector containing the decimation
    %   factor of the first and second filter stages in the first and
    %   second elements respectively. If the third filter stage is not
    %   bypassed then M is a 1x3 vector containing the decimation factor of
    %   the first, second, and third filter stages.
    %
    %   See also visualizeFilterStages, dsp.DigitalDownConverter.fvtool,
    %   groupDelay, getFilters, getFilterOrders.
    
    % If no design is available, design filters using double arithmetic.
    if ~(obj.pFilterDesigner.FilterDesignIsAvailable) 
      obj.pFilterDesigner.Arithmetic = 'double';
      design(obj.pFilterDesigner);
    end
    
    M = getDecimationFactors(obj.pFilterDesigner);
    
    if isThirdStageBypassed(obj.pFilterDesigner)
      M = M(1:2);
    end
  end
  %-----------------------------------------------------------------------
  % Set/Get methods
  %------------------------------------------------------------------------
  %CenterFrequency
  function set.CenterFrequency(obj,val)
    validateattributes( val, { 'double' }, { 'scalar', 'real' }, '', 'CenterFrequency');
    obj.CenterFrequency = val;
  end
  %---------------------------------------------  
  %SampleRate  
  function set.SampleRate(obj,val)
    validateattributes( val, { 'double' }, { 'scalar', 'positive', 'real' }, '', 'SampleRate');
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.SampleRate = val;
  end
  
  function val = get.SampleRate(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.SampleRate;
  end  
  %---------------------------------------------
  %DecimationFactor
  function set.DecimationFactor(obj,val)
    validateattributes( val, { 'double' }, { 'row', 'positive', 'integer' }, '', 'DecimationFactor');
    
    if (length(val) ~= 1) && (length(val) ~= 2) && (length(val) ~= 3)
      error(message('dsp:system:DigitalDownConverter_invalidDecimFactor'))
    end
    
    if (length(val) == 1)
      if val < 2
        error(message('dsp:system:DigitalDownConverter_invalidDecimFactorScalar'))
      end
      if isprime(val)
        error(message('dsp:system:DigitalDownConverter_invalidDecimFactorScalarPrime'))        
      end      
    end
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.DecimationFactor = val;
  end
  
  function val = get.DecimationFactor(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.DecimationFactor;
  end
  %---------------------------------------------  
  %FilterSpecification
  function set.FilterSpecification(obj,val)
     isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.FilterSpecification = val;
  end
  
  function val = get.FilterSpecification(obj)
     isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.FilterSpecification;
  end  
%---------------------------------------------  
  %MinimumOrderDesign
  function set.MinimumOrderDesign(obj,val)
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.MinimumOrderDesign = val;
    obj.MinimumOrderDesign = val;
  end
  
  function val = get.MinimumOrderDesign(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.MinimumOrderDesign;
  end  
  %---------------------------------------------
  %NumCICSections
  function set.NumCICSections(obj,val)
    validateattributes( val, { 'double' }, { 'scalar', 'positive', 'integer' }, '', 'NumCICSections');
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.OrderStage1 = val;
  end
  
  function val = get.NumCICSections(obj)
    val = obj.pFilterDesigner.OrderStage1;
  end  
  %---------------------------------------------
  %SecondFilterCoefficients
  function set.SecondFilterCoefficients(obj,val)
    validateattributes( val, { 'double' }, { 'row', 'real' }, '', 'SecondFilterCoefficients');
    
    isEmptyFilterDesigner(obj)    
    obj.pFilterDesigner.CoefficientsStage2 = val;
  end
  
  function val = get.SecondFilterCoefficients(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.CoefficientsStage2;
  end
  %---------------------------------------------
  %ThirdFilterCoefficients
  function set.ThirdFilterCoefficients(obj,val)
    validateattributes( val, { 'double' }, { 'row', 'real' }, '', 'ThirdFilterCoefficients');
    
    isEmptyFilterDesigner(obj)    
    obj.pFilterDesigner.CoefficientsStage3 = val;
  end
  
  function val = get.ThirdFilterCoefficients(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.CoefficientsStage3;
  end
  %---------------------------------------------
  %ThirdFilterOrder
  function set.ThirdFilterOrder(obj,val)
    validateattributes( val, { 'double' }, { 'scalar', 'positive', 'integer' }, '', 'ThirdFilterOrder');
    
    if mod(val,2) ~= 0
      error(message('dsp:system:DigitalDownConverter_oddThirdFilterOrder'))
    end
    
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.OrderStage3 = val;
  end
  
  function val = get.ThirdFilterOrder(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.OrderStage3;
  end
  %---------------------------------------------
  %StopbandFrequencySource
  function set.StopbandFrequencySource(obj,val)
    isEmptyFilterDesigner(obj)
    obj.pFilterDesigner.StopbandFrequencySource = val;
  end
  
  function val = get.StopbandFrequencySource(obj)
    isEmptyFilterDesigner(obj)
    val = obj.pFilterDesigner.StopbandFrequencySource;
  end
  %---------------------------------------------
  % Fixed point properties
  %---------------------------------------------
  function set.CustomThirdFilterCoefficientsDataType(obj,val)
    validateCustomDataType(obj,'CustomThirdFilterCoefficientsDataType',val, ...
      {'AUTOSIGNED','SCALED'});
    obj.CustomThirdFilterCoefficientsDataType = val;        
  end    
  function set.CustomFiltersInputDataType(obj,val)
    validateCustomDataType(obj,'CustomFiltersInputDataType',val, ...
      {'AUTOSIGNED','SCALED'});
    obj.CustomFiltersInputDataType = val;            
  end 
end
%--------------------------------------------------------------------------
% Hidden methods
%--------------------------------------------------------------------------
methods (Hidden)
  function hdlStruct = getFixedPointParameters(obj)
    % Return a structure with internal fixed point settings for HDL code
    % generation.
    
    if ~isLocked(obj)
      error(message('dsp:system:DigitalDownConverter_invalidObjectState'));
    end
    if obj.pIsInputFixedPoint
      
      hdlStruct.InputNumericType = obj.pInputNumericType;
      
      % Return oscillator output data type or NCO object
      if strcmp(obj.Oscillator,'Input port')
        oscType = obj.pInput2DataType;
        if strcmp(oscType, 'embedded.fi')
          nt = obj.pInput2NumericType;
        elseif any(strcmp(oscType,{'int8','int16','int32'}))
          nt = numerictype(true,str2double(oscType(4:end)),0);
        end
        hdlStruct.OscillatorOutputNumericType = nt;
      elseif strcmp(obj.Oscillator,'NCO')
        hdlStruct.NCOObject = clone(obj.pOscillator);
      end
      
      % Filters input numeric type
       hdlStruct.FiltersInputNumericType = obj.pFiltersInputNumericType;
       
      % Coarse CIC scaling output numeric type
      hdlStruct.CoarseCICScalingOutputNumericType =...
        obj.pReinterpretCastNumericType;
      
      % Fine scaling value
      hdlStruct.FineCICScaling = obj.pRemNormFactor;      
      
      % Output numeric type
      hdlStruct.OutputNumericType = obj.pOutputNumericType;
    else
      % Return empty structure if input is floating point
      hdlStruct = struct;
    end              
  end
  %------------------------------------------------------------------------
  function rateChangeFactors = getRateChangeFactors(obj)
    % Return the rate change factor for HDL code generation.
    M = getDecimationFactors(obj);
    if length(M) == 2
      M(end+1) = 1;
    end
    rateChangeFactors = [ones(3,1) M'];
  end
end
%--------------------------------------------------------------------------
% Protected methods
%--------------------------------------------------------------------------
methods (Access = protected)
  function num = getNumInputsImpl(obj)
    num = 1 + strcmp(obj.Oscillator,'Input port');
  end
  %------------------------------------------------------------------------
  function validateInputsImpl(obj,x,varargin)
    
    % Get size and data type of input
    obj.pInputSize = size(x);
    
    
    obj.pInputDataType = getInputType(obj,x);
        
    if getNumInputsImpl(obj) == 2
      obj.pInput2DataType = getInputType(obj,varargin{1});
      if strcmp(obj.pInput2DataType, 'embedded.fi')
        obj.pInput2NumericType = numerictype(...
          true,varargin{1}.WordLength,varargin{1}.FractionLength);
      end
    end
        
    % Validate dimensions of input vector. X must be a column vector with a
    % size that is an integer multiple of the decimation factor.
    if ~ismatrix(x) || isempty(x)
      matlab.system.internal.error('MATLAB:system:inputMustBeMatrix', ...
        'X');
    end
    
    if (obj.pInputSize(1) < prod(obj.DecimationFactor)) ||...
        (mod(obj.pInputSize(1),prod(obj.DecimationFactor)) > 0)
      error(message('dsp:system:DigitalDownConverter_invalidInputDim'))
    end
    
    % Get the numeric type if input is fixed point, set all input type
    % properties.
    setInputOutputTypes(obj,x)
          
    if (obj.pIsInputFixedPoint || obj.pCastOutputToFloatingFi) && ...
        (obj.pInputSize(2) > 1)
      % Multichannel is only supported for double or single precision
      % inputs
      error(message('dsp:system:DigitalDownConverter_invalidMultichannel'))
    end
      
    if obj.pIsInputFixedPoint
      % Set the numeric type of the filter inputs, and the filter
      % coefficients if user specified coefficients
      
      if strcmp(obj.FiltersInputDataType,'Same as input')
        obj.pFiltersInputNumericType = numerictype([],...
          obj.pInputNumericType.WordLength,...
          obj.pInputNumericType.FractionLength);
      else
        obj.pFiltersInputNumericType = numerictype([],...
          obj.CustomFiltersInputDataType.WordLength,...
          obj.CustomFiltersInputDataType.FractionLength);
      end
      
      if strcmp(obj.FilterSpecification,'Coefficients')                
        if strcmp(obj.ThirdFilterCoefficientsDataType,'Same as input')
          obj.pThirdFilterCoefficientsNumericType = numerictype([],...
            obj.pInputNumericType.WordLength,...
            obj.pInputNumericType.FractionLength);
        else
          obj.pThirdFilterCoefficientsNumericType = numerictype([],...
            obj.CustomThirdFilterCoefficientsDataType.WordLength,...
            obj.CustomThirdFilterCoefficientsDataType.FractionLength);
        end      
      end      
    end
    
    % If Oscillator is 'Input port' then oscillator input must have
    % the same dimensions as input. The oscillator input must
    % be complex.
    if strcmp(obj.Oscillator,'Input port')
      z = varargin{1};
      if any([obj.pInputSize(1) 1] ~= size(z))
        error(message('dsp:system:DigitalDownConverter_invalidInputZDims'))
      end
      if isreal(z)
        error(message('dsp:system:DigitalDownConverter_invalidInputZComplexity'))
      end
      if strcmp(obj.pInputDataType,'double') || ...
          strcmp(obj.pInputDataType,'single')
        if ~strcmp(obj.pInputDataType,class(z))
          error(message('dsp:system:DigitalDownConverter_invalidInputZTypeFloating'))
        end
      end      
    end
  end
  %------------------------------------------------------------------------
  function setupImpl(obj,~,varargin)
    
    % Design the decimation filter stages.
    designDecimatorCascade(obj);
    
    % Allocate buffer with predefined data type for [cic-normalization
    % factor] output
    Mvect = getDecimationFactors(obj.pFilterDesigner);
    sz = [obj.pInputSize(1)/Mvect(1) obj.pInputSize(2)];
    if obj.pIsInputFixedPoint
      obj.pInitCICNormOutput = fi(zeros(sz),obj.pFiltersInputNumericType);
    else
      obj.pInitCICNormOutput = zeros(sz, obj.pInputDataType);
    end

    % Allocate buffer with predefined data type for oscillator and mixer
    % outputs. Define oscillator output data type. 
    if obj.pIsInputFixedPoint
      obj.pInitMixerOutput = fi(zeros(obj.pInputSize),...
        obj.pFiltersInputNumericType);
      
      if ~any(strcmp({'Input port','None'},obj.Oscillator))
        obj.pOscillatorOutputNumericType = ...
          numerictype([],obj.pInputNumericType.WordLength+1,...
          obj.pInputNumericType.WordLength-1);
        obj.pInitOscillatorOutput = fi(zeros(obj.pInputSize(1),1),...
          obj.pOscillatorOutputNumericType);
      end
    else
      obj.pInitMixerOutput = zeros(obj.pInputSize, obj.pInputDataType);
      if ~any(strcmp({'Input port','None'},obj.Oscillator))
        obj.pInitOscillatorOutput = zeros(obj.pInputSize(1),1,obj.pInputDataType);
      end
    end
    
    % Design the oscillator
    if ~any(strcmp({'Input port','None'},obj.Oscillator))
      % Pass the frame length and sampling rate to the designOscillator
      % method
      designOscillator(obj,obj.pInputSize(1),obj.SampleRate)
    end        
    
    % Assign function handles to pOscillatorFunction, pMixerFunction,
    % pThirdStageFilterFunction, and pOutputCastFunction
    if strcmp(obj.Oscillator,'Input port')
      obj.pOscillatorFunction = @dsp.DigitalDownConverter.noAction;
      if obj.pIsInputFixedPoint || obj.pCastOutputToFloatingFi
        obj.pMixerFunction = @dsp.DigitalDownConverter.mixerFi;
      else
        obj.pMixerFunction = @dsp.DigitalDownConverter.mixer;
      end
    elseif strcmp(obj.Oscillator,'None') 
      obj.pOscillatorFunction = @dsp.DigitalDownConverter.noAction2;
      if obj.pIsInputFixedPoint
        obj.pMixerFunction = @dsp.DigitalDownConverter.noMixer;
      else
        obj.pMixerFunction = @dsp.DigitalDownConverter.noAction;
      end
    else
      obj.pOscillatorFunction =...
        @dsp.DigitalDownConverter.getOscillatorSignalFromObject;
      if obj.pIsInputFixedPoint || obj.pCastOutputToFloatingFi
        obj.pMixerFunction = @dsp.DigitalDownConverter.mixerFi;
      else
        obj.pMixerFunction = @dsp.DigitalDownConverter.mixer;
      end      
    end
    
    if isThirdStageBypassed(obj.pFilterDesigner)
      obj.pThirdStageFilterFunction = @dsp.DigitalDownConverter.noAction;
    else
      obj.pThirdStageFilterFunction = ...
        @dsp.DigitalDownConverter.filterWithThirdStage;
    end
    
    if obj.pCastOutputToBuiltInInteger
      obj.pOutputCastFunction = ...
        @dsp.DigitalDownConverter.castOutputDataToBuiltInInteger;
    elseif obj.pCastOutputToFloatingFi
      obj.pOutputCastFunction = ...
        @dsp.DigitalDownConverter.castOutputDataToFloatingFi;
    else
      obj.pOutputCastFunction = @dsp.DigitalDownConverter.noAction;
    end
    
    if obj.pIsInputFixedPoint
      obj.pNormalizeCICOutputFunction = ...
        @dsp.DigitalDownConverter.normalizeFixedPoint;
    else
      obj.pNormalizeCICOutputFunction = ...
        @dsp.DigitalDownConverter.normalizeFloatingPoint;
    end
    
  end  
  %------------------------------------------------------------------------
  function resetImpl(obj)
    reset(obj.pCIC)
    reset(obj.pCICComp)
    if ~isThirdStageBypassed(obj.pFilterDesigner)
      reset(obj.pStage3)
    end
    if ~any(strcmp({'Input port','None'},obj.Oscillator))
      reset(obj.pOscillator)
    end
  end
  
  %------------------------------------------------------------------------
  function releaseImpl(obj)
    release(obj.pCIC)
    release(obj.pCICComp)
    if ~isThirdStageBypassed(obj.pFilterDesigner)
      release(obj.pStage3)
    end
    if ~any(strcmp({'Input port','None'},obj.Oscillator))
      release(obj.pOscillator)
    end
  end
  
  %------------------------------------------------------------------------
  function y = stepImpl(obj,x,varargin)
    % Frequency down conversion
    
    % Oscillator  
    
    % sqrt(2) normalization to compensate for the carrier power is embedded
    % in the pCICNormalizationFactor
    w = obj.pOscillatorFunction(obj,varargin{:});
            
    % Mixer         
    s1 = obj.pMixerFunction(obj,x,w);    
    
    % CIC stage and CIC normalization
    s2 = step(obj.pCIC,s1);
    
    s3 = obj.pInitCICNormOutput;
    s3(:) = obj.pNormalizeCICOutputFunction(obj,s2); 
            
    % CIC compensator decimator
    s4 = step(obj.pCICComp, s3);
    
    % Third filter stage
    s5 = obj.pThirdStageFilterFunction(obj,s4);
        
    % Final cast (to built in integers, fi double, or fi single)
    y = obj.pOutputCastFunction(obj,s5);
  end
  
  %------------------------------------------------------------------------
  function flag = isInactivePropertyImpl(obj, prop)
      flag = false;
      switch prop
          case {'SecondFilterCoefficients', 'ThirdFilterCoefficients'}
              if strcmp(obj.FilterSpecification,'Design parameters')
                  flag = true;
              end
          case 'NumCICSections'
              if strcmp(obj.FilterSpecification,'Design parameters') && ...
                 obj.MinimumOrderDesign
                  flag = true;
              end
          case {'SecondFilterOrder', 'ThirdFilterOrder'}
              if (strcmp(obj.FilterSpecification,'Design parameters') && ...
                 obj.MinimumOrderDesign) || ...
                 ~strcmp(obj.FilterSpecification,'Design parameters')
                  flag = true;
              end
          case {'PassbandRipple','StopbandAttenuation'}
              if (strcmp(obj.FilterSpecification,'Design parameters') && ...
                 ~obj.MinimumOrderDesign) || ...
                 ~strcmp(obj.FilterSpecification,'Design parameters')
                   flag = true;
              end
          case 'StopbandFrequency'
              if (strcmp(obj.FilterSpecification,'Design parameters') && ...
                 strcmp(obj.StopbandFrequencySource,'Auto')) || ...
                 ~strcmp(obj.FilterSpecification,'Design parameters')
                   flag = true;
              end
          case {'MinimumOrderDesign', 'Bandwidth', 'StopbandFrequencySource'}
              if ~strcmp(obj.FilterSpecification,'Design parameters')
                  flag = true;
              end
          case {'NumAccumulatorBits', 'NumQuantizedAccumulatorBits','Dither'}
              if any(strcmp({'Input port','Sine wave','None'},obj.Oscillator))
                  flag = true;
              end
          case 'NumDitherBits'
              if any(strcmp({'Input port','Sine wave','None'},obj.Oscillator))|| ...
                 ~obj.Dither
                  flag = true;
              end
          case 'CenterFrequency'
              if any(strcmp({'Input port','None'},obj.Oscillator))
                  flag = true;
              end
          case 'CustomOutputDataType'
              if ~matlab.system.isSpecifiedTypeMode(obj.OutputDataType)
                  flag = true;
              end
          case 'CustomFiltersInputDataType'
              if ~matlab.system.isSpecifiedTypeMode(obj.FiltersInputDataType)
                  flag = true;
              end
          case {'SecondFilterCoefficientsDataType', 'ThirdFilterCoefficientsDataType'}
              if strcmp(obj.FilterSpecification,'Design parameters')
                  flag = true;
              end
          case 'CustomSecondFilterCoefficientsDataType'
              if strcmp(obj.FilterSpecification,'Design parameters') || ...
                 ~matlab.system.isSpecifiedTypeMode(obj.SecondFilterCoefficientsDataType)
                   flag = true;
              end
          case 'CustomThirdFilterCoefficientsDataType'
              if strcmp(obj.FilterSpecification,'Design parameters') || ...
                 ~matlab.system.isSpecifiedTypeMode(obj.ThirdFilterCoefficientsDataType)
                    flag = true;
              end
      end
  end   
  %------------------------------------------------------------------------
  function isEmptyFilterDesigner(obj)
    % If no filter designer object has been constructed, construct one
    if isempty(obj.pFilterDesigner)
      obj.pFilterDesigner = dsp.private.DownConverterFilterDesigner;
    end
  end  
  %------------------------------------------------------------------------  
  function flag = isFilterCoefficientsDataTypeSameAsInput(obj)
    % Return true if any of the SecondFilterCoefficientsDataType or
    % ThirdFilterCoefficientsDataType properties are set to 'Same as
    % input'.
   flag = strcmp(obj.SecondFilterCoefficientsDataType,'Same as input') || ...
          strcmp(obj.ThirdFilterCoefficientsDataType,'Same as input');
  end
  %------------------------------------------------------------------------  
  function checkFactorLength(obj)
    % Error out if decimation factor is not a 1x2 or 1x3 vector
    if length(obj.DecimationFactor)~= 3 && length(obj.DecimationFactor)~= 2
      error(message('dsp:system:DigitalDownConverter_decimFactorNotVector'));
    end
  end
  
  %------------------------------------------------------------------------  
  function checkFactorValues(obj)
    % Check value of DecimationFactor vector
    if strcmp(obj.FilterSpecification,'Design parameters')
      if (length(obj.DecimationFactor) == 3)
        if (obj.DecimationFactor(3) > 2)
          error(message('dsp:system:DigitalDownConverter_invalidDecimFactorThirdElement'));
        end
      end
      
      if length(obj.DecimationFactor) > 1
        if any(obj.DecimationFactor(1:2) < 2)
          error(message('dsp:system:DigitalDownConverter_invalidDecimFactorFirstSecondElements'));
        end
      end
    else
      if length(obj.DecimationFactor) > 1
        if any(obj.DecimationFactor(1) < 2)
          error(message('dsp:system:DigitalDownConverter_invalidDecimFactorFirstElement'));
        end
      end      
    end
  end
  %------------------------------------------------------------------------  
  function checkFsFc(obj)
    % Check that sample rate at oscillator input is at least twice the
    % oscillator frequency
    
    if ~strcmp(obj.Oscillator,'None') && ...
        (obj.SampleRate < 2*abs(obj.CenterFrequency))
      error(message('dsp:system:DigitalDownConverter_InvalidFs'));
    end
  end  
  %------------------------------------------------------------------------
  function setCustomCoefficientsDataType(obj)
      % Set coefficient data types of filter designer to the custom data
      % types specified by the user
      obj.pFilterDesigner.CoefficientsStage2DataType = ...
          obj.CustomSecondFilterCoefficientsDataType;
      obj.pFilterDesigner.CoefficientsStage3DataType = ...
          obj.CustomThirdFilterCoefficientsDataType;
  end
  %------------------------------------------------------------------------
  function s = saveObjectImpl(obj)
      s = saveObjectImpl@dsp.private.DigitalConverterBase(obj);
      s.pFilterDesigner = obj.pFilterDesigner;
      if isLocked(obj)
          s.pStage3 = matlab.System.saveObject(obj.pStage3);
          s.pFiltersInputNumericType = obj.pFiltersInputNumericType;
          s.pThirdFilterCoefficientsNumericType = obj.pThirdFilterCoefficientsNumericType;
          s.pOscillatorFunction = obj.pOscillatorFunction;
          s.pMixerFunction = obj.pMixerFunction;
          s.pThirdStageFilterFunction = obj.pThirdStageFilterFunction;
          s.pInput2DataType = obj.pInput2DataType;
          s.pInput2NumericType = obj.pInput2NumericType;
      end
  end
  %------------------------------------------------------------------------
  function loadObjectImpl(obj, s,wasLocked)
      loadSubObjects(obj,s,wasLocked);
      obj.pFilterDesigner = s.pFilterDesigner;
      if wasLocked
         obj.pStage3                             =  matlab.System.loadObject(s.pStage3);
         obj.pFiltersInputNumericType            = s.pFiltersInputNumericType;
         obj.pThirdFilterCoefficientsNumericType = s.pThirdFilterCoefficientsNumericType;
         obj.pOscillatorFunction                 = s.pOscillatorFunction;
         obj.pMixerFunction                      = s.pMixerFunction;
         obj.pThirdStageFilterFunction           = s.pThirdStageFilterFunction;
         if isfield(s,s.pInput2DataType)
          obj.pInput2DataType                    = s.pInput2DataType;
         end
         if isfield(s,s.pInput2NumericType)
           obj.pInput2NumericType                = s.pInput2NumericType;
         end
      end
      % Call the base class method
      loadObjectImpl@matlab.System(obj, s);
  end
end
%--------------------------------------------------------------------------
% Private methods
%--------------------------------------------------------------------------
methods (Access = private)  
  %------------------------------------------------------------------------
  function designDecimatorCascade(obj)
    % Design decimation filters
    
    %Design filters using the filter designer object.    
    
    %If user specified filter coefficients, and arithmetic is fixed, then
    %set the coefficient data types on the designer object.
    if strcmp(obj.FilterSpecification,'Coefficients') && ...
        strcmp(obj.pArithmetic,'fixed')
      obj.pFilterDesigner.CoefficientsStage2DataType = ...
        obj.pSecondFilterCoefficientsNumericType;
      obj.pFilterDesigner.CoefficientsStage3DataType = ...
        obj.pThirdFilterCoefficientsNumericType;
    end
    
    %Check if a design is available before calling the design method of the
    %filter designer object. Make sure that the available design has an
    %arithmetic that is congruent with the input data type.
    inputFixedPointArguments = {};
    if strcmpi(obj.pArithmetic,'fixed')
      inputFixedPointArguments = {obj.pFiltersInputNumericType};      
    end
    if obj.pFilterDesigner.FilterDesignIsAvailable && ...
        strcmp(obj.pFilterDesigner.Arithmetic,obj.pArithmetic)
      filterCell = ...
        getFilters(obj.pFilterDesigner,inputFixedPointArguments{:});      
    else
      obj.pFilterDesigner.Arithmetic = obj.pArithmetic;
      filterCell = design(obj.pFilterDesigner,inputFixedPointArguments{:});
    end
    
    %Set the properties with the filter System objects
    obj.pCIC = filterCell{1};
    obj.pCICComp = filterCell{2};
    obj.pStage3 = filterCell{3};
    obj.pCICNormalizationFactor = filterCell{4};    
    % Embed the carrier normalization (sqrt(2)) factor if Oscillator
    % source is not 'Input port' or 'None'.    
    if ~any(strcmp({'Input port','None'},obj.Oscillator))
      obj.pCICNormalizationFactor = sqrt(2)*obj.pCICNormalizationFactor;
    end

    % Set fixed point properties of filters
    if obj.pIsInputFixedPoint      
      
      % Output data types and filter input data types
      obj.pCICComp.OutputDataType = 'Custom';
      if  isThirdStageBypassed(obj.pFilterDesigner)
        % Set CIC compensator output data type to pOutputNumericType        
        obj.pCICComp.CustomOutputDataType = obj.pOutputNumericType;
      else
        % Set CIC compensator output data type to FiltersInputNumericType
        obj.pCICComp.CustomOutputDataType = obj.pFiltersInputNumericType;
        % Set third stage filter output data type to ntOutput
        obj.pStage3.OutputDataType = 'Custom';
        obj.pStage3.CustomOutputDataType = obj.pOutputNumericType;
      end
      
      % CIC Normalization 
      % Find the number of shifts needed to normalize up to the closest
      % power of 2 (coarse gain). 
      numCICOutputShifts = abs(nextpow2(obj.pCICNormalizationFactor));

      % The remaining normalization factor is done by multiplication with
      % the shifted CIC output (fine gain). We set the word length of this
      % value to 16 bits. We know number is in the interval [0.5 1] or [0.5
      % 1]*sqrt(2).
      obj.pRemNormFactor = fi(...
        (2^numCICOutputShifts)*obj.pCICNormalizationFactor, true, 16);

      % WL at CIC output
      numCICOutputBits = obj.pFiltersInputNumericType.WordLength + ...
        ceil(log2(obj.pCIC.DecimationFactor^obj.pCIC.NumSections)); 

      % Set the numeric type object that will be used to reinterpret cast
      % the CIC output and achieve the nextpow2 coarse normalization gain.      
      obj.pReinterpretCastNumericType = numerictype(true,numCICOutputBits,...
        obj.pFiltersInputNumericType.FractionLength+numCICOutputShifts);  
      
    else % Input is not fixed point
      obj.pCICNormalizationFactor = cast(...
        obj.pCICNormalizationFactor,obj.pInputDataType);
    end
  end
end
%--------------------------------------------------------------------------
% Static methods
%--------------------------------------------------------------------------
methods(Static)
  function helpFixedPoint
    %helpFixedPoint Display dsp.DigitalDownConverter System object 
    %               fixed-point information
    %   dsp.DigitalDownConverter.helpFixedPoint displays information about
    %   fixed-point properties and operations of the
    %   dsp.DigitalDownConverter System object.

    matlab.system.dispFixptHelp('dsp.DigitalDownConverter', ...
      dsp.DigitalDownConverter.getDisplayFixedPointProperties);
  end
end

methods (Static, Hidden)
  % Needed by helpFixedPoint and getPropertyGroupsImpl
  function props = getDisplayFixedPointProperties()
    props = {...
      'SecondFilterCoefficientsDataType',...
      'CustomSecondFilterCoefficientsDataType',...
      'ThirdFilterCoefficientsDataType',...
      'CustomThirdFilterCoefficientsDataType',...      
      'FiltersInputDataType',...
      'CustomFiltersInputDataType',...
      'OutputDataType',...
      'CustomOutputDataType'};
  end  
  
  %-------------------------------------------------------------------------
  % Static Helper Methods
  function dataOut = getOscillatorSignalFromObject(obj,~)
    % In this case, input data is a vector of zeros with the desired
    % oscillator output data type.
    dataOut = obj.pInitOscillatorOutput;
    dataOut(:) = step(obj.pOscillator);
  end
  
  function dataOut = mixer(obj,dataIn,oscData)
    % pInitMixerOutput is a vector of zeros with the data type that we want
    % to have at the output of the mixer. Assigning the mixer output to
    % dataOut(:) automatically casts the mixer output to the data type in
    % obj.pInitMixerOutput. This function uses bsxfun and only works for
    % double or single inputs. Fixed point mixer is implemented in the
    % mixerFi function
    dataOut = obj.pInitMixerOutput;
    dataOut(:) = bsxfun(@times,dataIn,conj(oscData));
  end
  
  function dataOut = mixerFi(obj,dataIn,oscData)
    % pInitMixerOutput is a vector of zeros with the data type that we want
    % to have at the output of the mixer. Assigning the mixer output to
    % dataOut(:) automatically casts the mixer output to the data type in
    % obj.pInitMixerOutput.
    dataOut = obj.pInitMixerOutput;
    dataOut(:) = dataIn.*conj(oscData);
  end  
  
  function dataOut = noMixer(obj,dataIn,~)
    % pInitMixerOutput is a vector of zeros with the data type that we want
    % to have at the output of the mixer. Assigning the mixer output to
    % dataOut(:) automatically casts the mixer output to the data type in
    % obj.pInitMixerOutput.
    dataOut = obj.pInitMixerOutput;
    dataOut(:) = dataIn;
  end
  
  function dataOut = filterWithThirdStage(obj,dataIn)
    dataOut = step(obj.pStage3,dataIn);
  end
  
  function dataOut = castOutputDataToBuiltInInteger(obj,dataIn)
    dataOut = cast(dataIn,obj.pInputDataType);
  end
  
  function dataOut = castOutputDataToFloatingFi(obj,dataIn)
    dataOut = fi(dataIn,obj.pInputNumericType);
  end
  
  function dataOut = noAction(~,dataIn,varargin)
    dataOut = dataIn;
  end
  
  function dataOut = noAction2(~)
    dataOut = 1;
  end
    
  function dataOut = normalizeFixedPoint(obj,dataIn)
    %   Normalize (coarse gain) using reinterpretcast method. Complete remaining
    %   normalization (fine gain) with multiplication
    x = reinterpretcast(dataIn,obj.pReinterpretCastNumericType);
    dataOut = x*obj.pRemNormFactor;
  end
  
  function dataOut = normalizeFloatingPoint(obj,dataIn)
    dataOut = dataIn*obj.pCICNormalizationFactor;
  end
end

methods(Static,Hidden,Access=protected)
  function groups = getPropertyGroupsImpl
    props = {...
      'SampleRate',...
      'DecimationFactor',...
      'FilterSpecification',...
      'MinimumOrderDesign',...
      'NumCICSections',...
      'SecondFilterCoefficients',...
      'ThirdFilterCoefficients',...
      'SecondFilterOrder',...
      'ThirdFilterOrder',...
      'Bandwidth',...
      'StopbandFrequencySource',...
      'StopbandFrequency',...
      'PassbandRipple',...
      'StopbandAttenuation',...
      'Oscillator',...
      'CenterFrequency',...
      'NumAccumulatorBits',...
      'NumQuantizedAccumulatorBits',...
      'Dither',...
      'NumDitherBits'};
    
    mainS = matlab.system.display.Section('Title', 'Parameters', ...
                                          'PropertyList', props);
    mainSG = matlab.system.display.SectionGroup('Title', 'Main', ...
                                                'Sections', mainS);
    dtSG = matlab.system.display.SectionGroup('Title', 'Data Types', ...
             'PropertyList', ...
             dsp.DigitalDownConverter.getDisplayFixedPointProperties);
    groups = [mainSG, dtSG];
  end
end
end
