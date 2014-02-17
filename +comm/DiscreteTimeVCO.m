classdef DiscreteTimeVCO < matlab.System & matlab.system.mixin.Nondirect
%DiscreteTimeVCO Generate variable frequency sinusoid
%   H = comm.DiscreteTimeVCO creates a discrete-time voltage-controlled
%   oscillator (VCO) System object, H. This object generates a sinusoidal
%   signal with its frequency shifted from the specified quiescent frequency
%   to a value proportional to the input signal.
%
%   H = comm.DiscreteTimeVCO(Name,Value) creates a discrete-time VCO object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) generates a sinusoidal signal, Y, with frequency shifted,
%   from the value you specify in the QuiescentFrequency property, to a
%   value proportional to the input signal, X. The input, X, must be a
%   double or single precision, real, scalar value. The output, Y, has the
%   same data type and size as the input, X.
%
%   DiscreteTimeVCO methods:
%
%   step     - Generate sinusoid signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create discrete-time VCO object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of discrete-time VCO object
%
%   DiscreteTimeVCO properties:
%
%   OutputAmplitude    - Amplitude of output signal
%   QuiescentFrequency - Frequency of output signal when input is zero
%   Sensitivity        - Sensitivity of frequency shift of output signal
%   InitialPhase       - Initial phase of output signal
%   SampleRate         - Sample rate of input
%
%   % Example: 
%   %   Generate an FSK signal using a discrete time VCO
%
%   % Create a SignalSource System object and generate random data
%   hreader = dsp.SignalSource;
%   hreader.Signal = randi([0 7],10,1);
%   % Rectangular pulse shaping
%   hreader.Signal = rectpulse(hreader.Signal, 100);
%   % Create a signal logger System object
%   hlogger = dsp.SignalSink; 
%   % Create a discrete time VCO object and generate an FSK signal
%   hdvco = comm.DiscreteTimeVCO('OutputAmplitude',8, ...
%                                'QuiescentFrequency',1);
%   while(~isDone(hreader))
%     sig = step(hreader);
%     y = step(hdvco,sig);
%     step(hlogger,y);
%   end
%   oscsig = hlogger.Buffer;
%   % Plot FSK signal
%   t = [0:length(oscsig)-1]'/hdvco.SampleRate;
%   plot(t,hreader.Signal,'--r', 'LineWidth',3); hold on;
%   plot(t,oscsig,'-b'); hold off;
%   xlabel('time (s)');
%   legend('Input Signal', 'FSK Signal');
% 
%   See also comm.CPMCarrierPhaseSynchronizer,
%            comm.PSKCarrierPhaseSynchronizer.

%   Copyright 2010-2012 The MathWorks, Inc.

%#codegen
%#ok<*EMCLS>

properties
  %OutputAmplitude Amplitude of output signal
  %   Specify the amplitude of the output signal as a double or single
  %   precision, scalar value. The default is 1. This property is tunable.
  OutputAmplitude = 1;
  %QuiescentFrequency Frequency of output signal when input is zero
  %   Specify the quiescent frequency of the output signal in Hertz, as a
  %   double or single precision, real, scalar value. The default is 10.
  %   This property is tunable.
  QuiescentFrequency = 10;
  %Sensitivity Sensitivity of frequency shift of output signal
  %   Specify the sensitivity of the output signal frequency shift to the
  %   input as a double or single precision, real, scalar value. This value
  %   scales the input voltage and, consequently, the shift from the
  %   quiescent frequency value. The units of Sensitivity are Hertz per
  %   volt. The default is 1. This property is tunable.
  Sensitivity = 1; 
end

properties (Nontunable)
  %InitialPhase Initial phase of output signal
  %   Specify the initial phase of the output signal, in radians, as a
  %   double or single precision, real, scalar value. The default is 0.
  InitialPhase = 0; 
  %SampleRate Sample rate of input
  %   Specify the sample rate of the input, in Hz, as a double or
  %   single precision, positive, scalar value. The default is 100.
  SampleRate = 100;
end

properties(Access = private, Nontunable)
  p2pi;  % 2*pi constant used in angle wrapping operation in the 
         % stepImpl function
end

properties(Access = private)
  pAccumAngle;    % accumulated angle
  pFcRadiansTs;   % 2*pi*QuiescentFrequency*Ts
  pKcRadPerVTs;   % 2*pi*Sensitivity*Ts
  pYAttributes;   % Store attributes of output buffer as another buffer
end

methods
  % CONSTRUCTOR
  function obj = DiscreteTimeVCO(varargin)
    setProperties(obj, nargin, varargin{:});
  end
  
  % set properties validation
  function set.OutputAmplitude(obj, value)
    validateattributes( value, { 'double', 'single' }, { 'scalar' }, '', 'OutputAmplitude'); %#ok<EMCA>
    obj.OutputAmplitude = value;
  end
  function set.QuiescentFrequency(obj, value)
    validateattributes( value, { 'double', 'single' }, { 'scalar', 'real' }, '', 'QuiescentFrequency'); %#ok<EMCA>
    obj.QuiescentFrequency = value;
  end 
  function set.Sensitivity(obj, value)
    validateattributes( value, { 'double', 'single' }, { 'scalar', 'real' }, '', 'Sensitivity'); %#ok<EMCA>
    obj.Sensitivity = value;
  end 
  function set.InitialPhase(obj, value)
    validateattributes( value, { 'double', 'single' }, { 'scalar', 'real' }, '', 'InitialPhase'); %#ok<EMCA>
    obj.InitialPhase = value;
  end 
  function set.SampleRate(obj, value)
    validateattributes( value, { 'double', 'single' }, { 'scalar', 'positive' }, '', 'SampleRate'); %#ok<EMCA>
    obj.SampleRate = value;
  end 
end

methods(Access = protected)
  function validateInputsImpl(~,x)
  % complex input is not supported
      coder.internal.errorIf(~isreal(x), 'comm:sysObj:DiscreteTimeVCO_expectedInputReal');
    if ~isfloat(x)
      matlab.system.internal.error(...
        'MATLAB:system:invalidInputDataType','X','floating-point');
    end    
    % must be a scalar or a column vector (single-channel)
    if ~isscalar(x)
      matlab.system.internal.error(...
        'MATLAB:system:inputMustBeScalar','X');
    end
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
    
  function setupImpl(obj, x)
  % Input cannot be fi-double or fi-single. This check can be moved to
  % validateInputsImpl when we have a mechanism to know, without looking at
  % actual input data, that this data is a fi object.
      coder.internal.errorIf( isa(x, 'embedded.fi'), 'comm:sysObj:DiscreteTimeVCO_invalidFiInput');
    
    temp2pi = comm.DiscreteTimeVCO.getAttributesFromInput([1 1], x);
    temp2pi(1) = 2*pi;
    obj.p2pi = temp2pi;
    obj.pAccumAngle = comm.DiscreteTimeVCO.getAttributesFromInput([1 1], x);
    obj.pYAttributes = ...
      comm.DiscreteTimeVCO.getAttributesFromInput([1 1], x);
    obj.localInit;   % initialize pFcRadiansTs and pKcRadPerVTs
  end
  
  function processTunedPropertiesImpl(obj)
    obj.localInit;   % re-initialize pFcRadiansTs and pKcRadPerVTs
  end
  
  function resetImpl(obj)
    obj.pAccumAngle(1) = obj.InitialPhase;
  end
  
  function y = outputImpl(obj, ~)
    % cast output to the same data type as the input
    obj.pYAttributes(1)  = obj.OutputAmplitude* cos(obj.pAccumAngle);
    y = obj.pYAttributes;
  end
  
  function updateImpl(obj, x)
    obj.pAccumAngle = x * obj.pKcRadPerVTs +...
                obj.pFcRadiansTs +...
                obj.pAccumAngle;
    obj.pAccumAngle = mod( obj.pAccumAngle, obj.p2pi );
  end
  
  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      s.pAccumAngle = obj.pAccumAngle;
      s.pFcRadiansTs = obj.pFcRadiansTs;
      s.pKcRadPerVTs = obj.pKcRadPerVTs;
      s.pYAttributes = obj.pYAttributes;
    end
  end
  
  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      obj.pAccumAngle = s.pAccumAngle;
      obj.pFcRadiansTs = s.pFcRadiansTs;
      obj.pKcRadPerVTs = s.pKcRadPerVTs;
      obj.pYAttributes = s.pYAttributes;
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end
end

methods(Access=private)   % local/ helper functions
  function localInit(obj)
    % initialize constants that depend on properties
    obj.pFcRadiansTs = 2*pi* obj.QuiescentFrequency / obj.SampleRate;
    obj.pKcRadPerVTs = 2*pi* obj.Sensitivity / obj.SampleRate;
  end
end

methods(Static, Hidden)  
  function out=getAttributesFromInput(size, x)
      if isa(x, 'embedded.fi')
          out = fi(zeros(size), numerictype(x));
      else
          out = cast(zeros(size), class(x));
      end
  end
end
end
