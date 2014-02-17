classdef AGC < matlab.System & matlab.system.mixin.CustomIcon
%AGC Automatic gain controller
%   H = comm.AGC creates an automatic gain controller (AGC) System object,
%   H, that adaptively adjusts its gain to achieve a constant signal level
%   at the output.
%
%   H = comm.AGC(Name,Value) creates an AGC object, H, with the specified
%   property Name set to the specified Value. You can specify additional
%   name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H, X) applies an adaptive gain to the input X, to achieve a
%   unity signal level at the output, Y. X must be a double or single
%   precision column vector. AGC determines the output signal level based
%   on the DetectorMethod setting.
%
%   AGC methods:
%
%   step     - Generate Barker code samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create AGC object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of AGC object
%
%   AGC properties:
%
%   DetectorMethod - Detector method
%   LoopMethod     - Loop method
%   UpdatePeriod   - Period of gain updates in samples
%   StepSize       - Step size for gain updates
%   MaximumGain    - Maximum gain (dB)
%   GainOutputPort - Enable gain output
%
%   % Example:
%   %   Set the received symbol magnitude to approximately 1 for
%   %   a QPSK signal.
%
%   hMod = comm.PSKModulator(4, 'PhaseOffset', pi/4);
%   hChan = comm.AWGNChannel('EbNo', 20);
%   hAGC = comm.AGC;
%   d = randi([0 3], 10000, 1);
%   x = step(hMod, d);
%   c = 4*step(hChan, x);
%   y = step(hAGC, c);
%   % Plot after AGC reaches steady state
%   figure;plot(c(1000:end), '*')
%   hold on;plot(y(1000:end), 'or'); grid on; axis square
%   legend('Input of AGC', 'Output of AGC')

%   Copyright 2011-2013 The MathWorks, Inc.

%#codegen
  
properties (Nontunable)
  %DetectorMethod Detector method
  %   Specify the detector method as one of 'Rectifier' | 'Square Law'. The
  %   default is 'Rectifier'.
  %
  %   When you set the DetectorMethod to 'Rectifier', the AGC detector
  %   outputs a voltage value proportional to the envelope amplitude of the
  %   output signal. The detector first rectifies the input signal and then
  %   passes through a filter to average the rectified signal. The AGC
  %   adjusts the gain to obtain unity voltage at the output of the
  %   detector.
  %   
  %   When you set the DetectorMethod to 'Square law', the AGC detector
  %   outputs a power value that is proportional to the square of the
  %   output voltage. The detector first squares the input signal and then
  %   passes through a filter. The AGC adjusts the gain to obtain unity
  %   power at the output of the detector.
  DetectorMethod = 'Rectifier';
  %LoopMethod Loop method
  %   Specify the loop method of the AGC as one of 'Linear' |
  %   'Logarithmic'. The default is 'Linear'. 
  %
  %   When you set the LoopMethod to 'Linear', the AGC uses the direct
  %   value of the detector output to determine gain value. Such a loop
  %   tends to respond large increases in the input signal level fairly
  %   quickly. However, the response to large decreases in the input signal
  %   level tends to be slow.
  %
  %   When you set the LoopMethod to 'Logarithmic', the AGC uses the
  %   logarithm of the detector output to determine the gain value. Such a
  %   loop acts faster to changes in the input signal level, especially to
  %   large decreases in the input signal level.
  LoopMethod = 'Linear';
  %UpdatePeriod Period of gain updates in samples
  %   Specify the period of the gain updates as a double or single
  %   precision, real integer valued scalar. The number of input samples
  %   must be an integer multiple of update period. The default is 100.
  %   Setting the period greater than one increases the speed of the AGC
  %   algorithm.
  UpdatePeriod = 100;
  %StepSize Step size
  %   Specify the step size for gain updates as a double or single
  %   precision, real, positive scalar. The default is 0.1. If you
  %   increase the loop gain, AGC responds to changes at the input signal
  %   level faster. However, gain pumping also increase.
  StepSize = 0.1;
  %MaximumGain Maximum gain (dB)
  %   Specify the maximum gain of the AGC in dB as a positive scalar. The
  %   default is 30. If the signal at the input of the AGC has a very low
  %   signal level, the AGC gain may increase rapidly. You can use this
  %   property to limit the gain AGC can apply to the input signal.
  MaximumGain = 30;
end
  
properties (Nontunable, Logical)
  %GainOutputPort Enable gain output
  %   When you set this property to true, the step method outputs
  %   instantaneous gain values. The default is false.
  GainOutputPort = false;
end

properties (Access = private)
  pDetectorFunction
  pDetectorOutputFun
end

properties (Access = private, Nontunable)
  ReferenceLevel = 1;
  pOutputBuffer
  pRef
  pMaxGain
  pMinGain
end

properties (DiscreteState, Hidden)
  Gain
end

properties(Constant, Hidden)
  DetectorMethodSet = matlab.system.StringSet({'Rectifier', 'Square Law'});
  LoopMethodSet = matlab.system.StringSet({'Linear','Logarithmic'});
end

methods
  function obj = AGC(varargin)   
    setProperties(obj, nargin, varargin{:}); 
  end
  
  function set.StepSize(obj, val)
    validateattributes(val, {'numeric'}, ...
      {'scalar', 'positive', 'finite', 'nonnan'}, ...
      '', 'StepSize'); %#ok<EMCA>
    obj.StepSize = val;
  end
  
  function set.UpdatePeriod(obj, val)
    validateattributes(val, {'numeric'}, ...
      {'scalar', 'integer', 'positive', 'finite', 'nonnan'}, ...
      '', 'UpdatePeriod'); %#ok<EMCA>
    obj.UpdatePeriod = val;
  end
  
  function set.MaximumGain(obj, val)
    validateattributes(val, {'numeric'}, ...
      {'scalar', 'finite', 'nonnan'}, ...
      '', 'MaximumGain'); %#ok<EMCA>
    obj.MaximumGain = val;
  end
end

methods (Access = protected)
  function validateInputsImpl(~, x)
    validateattributes(x, {'numeric'}, ...
      {'column'}, 'step', 'X'); %#ok<EMCA>
  end
  
  function setupImpl(obj, x)
    validateattributes(x, {'double', 'single'}, {'column'}, 'step', ...
      'X', 1); %#ok<EMCA>
    
    inputDType = class(x);
    % Real is a subset of complex.  Also, if all the inputs are real,
    % MATLAB will make y, the output variable in stepImpl, real.
    obj.pOutputBuffer = complex(cast(zeros(size(x)), inputDType));
    obj.Gain = cast(1, inputDType);
    
    maxGain = 10^(obj.MaximumGain/10);
    obj.pMinGain = cast(sqrt(eps), inputDType);
    
    if strncmp(obj.LoopMethod, 'Logarithmic', 11)
      obj.pRef = cast(log(obj.ReferenceLevel), inputDType);
      obj.pMaxGain = cast(log(maxGain), inputDType);
    else
      obj.pRef = cast(obj.ReferenceLevel, inputDType);
      obj.pMaxGain = cast(maxGain, inputDType);
    end

    if strncmp(obj.DetectorMethod, 'Rectifier', 3)
      obj.pDetectorFunction = @rectifier;
      obj.pDetectorOutputFun = @rectifierOutput;
    else
      obj.pDetectorFunction = @squarelaw;
      obj.pDetectorOutputFun = @squarelawOutput;
    end
    
    coder.internal.errorIf(mod(length(x), obj.UpdatePeriod) ~= 0, ...
      'comm:AGC:WrongInputLength');
  end

  function [y,gVec] = stepImpl(obj, x)
    
    g = obj.Gain;
    y = obj.pOutputBuffer;
    gVec = y;
    K = obj.StepSize;
    ref = obj.pRef;
    maxGain = obj.pMaxGain;
    minGain = obj.pMinGain;
    detectorFun = obj.pDetectorFunction;
    detectorOutFun = obj.pDetectorOutputFun;
    updatePeriod = obj.UpdatePeriod;
    numSubFrames = length(x)/updatePeriod;

    z = detectorFun(reshape(x, updatePeriod, numSubFrames));
          
    indices = 1:updatePeriod;
    switch obj.LoopMethod
      case 'Linear'
        for p=1:numSubFrames
          y(indices) = x(indices) * g;
          gVec(indices) = g;
          e = ref - detectorOutFun(z(p), g);
          g = g + K*e;
          if g < minGain
            g = minGain;
          elseif g > maxGain
            g = maxGain;
          end
          indices = indices + updatePeriod;
        end
      case 'Logarithmic'
        for p=1:numSubFrames
          expg = exp(g);
          y(indices) = x(indices) * expg;
          gVec(indices) = g;
          zTemp = detectorOutFun(z(p), expg);
          e = ref - log(zTemp);
          g = g + K*e;
          if g > maxGain
            g = maxGain;
          end
          indices = indices + updatePeriod;
        end
    end
    
    obj.Gain = g;
  end

  function [sz,dt,cp] = getDiscreteStateSpecificationImpl(obj, x) %#ok<INUSL>
    % Return state information for Gain
    sz = [1 1];
    dt = class(x);
    cp = false;
  end
  
  function resetImpl(obj)
    obj.Gain(1) = 1;
    if strncmp(obj.LoopMethod, 'Logarithmic', 11)
      obj.Gain(1) = log(obj.Gain);
    end
  end

  function num = getNumOutputsImpl(obj)
    num = 1 + obj.GainOutputPort;
  end

  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      s.pDetectorFunction  = obj.pDetectorFunction;
      s.pDetectorOutputFun = obj.pDetectorOutputFun;
      s.ReferenceLevel     = obj.ReferenceLevel;
      s.pOutputBuffer      = obj.pOutputBuffer;
      s.pRef               = obj.pRef;
      s.pMaxGain           = obj.pMaxGain;
      s.pMinGain           = obj.pMinGain;
      s.Gain               = obj.Gain;
    end
  end

  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      if ~isfield(s, 'pDetectorFunction')
        % 13a object
        if strncmp(s.DetectorMethod, 'Rectifier', 3)
          obj.pDetectorFunction  = @rectifier;
          obj.pDetectorOutputFun = @rectifierOutput;
        else
          obj.pDetectorFunction = @squarelaw;
          obj.pDetectorOutputFun = @squarelawOutput;
        end
        obj.ReferenceLevel     = s.ReferenceLevel;
        obj.pOutputBuffer      = s.pOutputBuffer;
        obj.pRef               = s.pRef;
        obj.pMaxGain           = s.pMaxGain;
        obj.pMinGain           = s.pMinGain;
        obj.Gain               = s.Gain;
      else
        obj.pDetectorFunction  = s.pDetectorFunction;
        obj.pDetectorOutputFun = s.pDetectorOutputFun;
        obj.ReferenceLevel     = s.ReferenceLevel;
        obj.pOutputBuffer      = s.pOutputBuffer;
        obj.pRef               = s.pRef;
        obj.pMaxGain           = s.pMaxGain;
        obj.pMinGain           = s.pMinGain;
        obj.Gain               = s.Gain;
      end
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end

  function icon = getIconImpl(~)
    icon = sprintf('AGC');
  end
  
  function varargout = getInputNamesImpl(obj)
    varargout = cell(1, getNumInputs(obj));
    varargout{1} = '';
  end
  
  function varargout = getOutputNamesImpl(obj)
    varargout = cell(1, getNumOutputs(obj));
    varargout{1} = '';
    
    if obj.GainOutputPort
      varargout{2} = 'Gain';
    end
  end
end
end

function y = rectifier(x)
y = mean(abs(x),1);
end

function y = squarelaw(x)
y = mean(abs(x).^2,1);
end

function z = rectifierOutput(z, g)
z = z * g;
end

function z = squarelawOutput(z, g)
z = z*g^2;
end
