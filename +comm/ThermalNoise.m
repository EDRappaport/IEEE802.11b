classdef ThermalNoise < matlab.System & matlab.system.mixin.Propagates
%ThermalNoise Add receiver thermal noise
%   H = comm.ThermalNoise creates a receiver thermal noise System object, H.
%   This object adds thermal noise to the complex, baseband input signal.
%
%   H = comm.ThermalNoise(Name,Value) creates a receiver thermal noise
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   The thermal noise object uses the default MATLAB random stream. Reset
%   the default stream for repeatable simulations. Type 'help RandStream'
%   for more information.
%
%   Step method syntax:
%
%   Y = step(H,X) adds thermal noise to the complex, baseband input signal,
%   X, and outputs the result in Y. The input signal X must be a complex,
%   double or single precision data type column vector or scalar.
%
%   ThermalNoise methods:
%
%   step     - Add receiver thermal noise to input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create thermal noise object with same property values
%   isLocked - Locked status (logical)
%
%   ThermalNoise properties:
%
%   NoiseMethod      - Method to specify noise level
%   NoiseTemperature - Noise temperature
%   NoiseFigure      - Noise figure
%   NoiseFactor      - Noise factor
%   SampleRate       - Sample rate
%
%   % Example: 
%   %   Add thermal noise with a noise temperature of 290 degrees Kelvin to
%   %   QPSK data 
%
%   hTNoise = comm.ThermalNoise('NoiseTemperature',290);
%   % Create a modulator and obtain complex baseband signal
%   hMod = comm.QPSKModulator;
%   data = randi([0 3],32,1);
%   modData = step(hMod,data);
%   % Add noise to signal
%   noisyData = step(hTNoise,modData);
%
%   See also comm.AWGNChannel.

%   Copyright 2009-2012 The MathWorks, Inc.

%#codegen
%#ok<*EMCLS>

properties (Nontunable)  
  %NoiseMethod Method to specify noise level
  %   Select the method to specify the noise level as one of 'Noise
  %   temperature' | 'Noise figure' | 'Noise factor'. The default is 'Noise
  %   temperature'.
  NoiseMethod = 'Noise temperature';
  %NoiseTemperature Noise temperature
  %   Specify the noise temperature in degrees Kelvin as a numeric,
  %   nonnegative, real scalar. This property applies when you set the
  %   NoiseMethod property to 'Noise temperature'. The default is 290
  %   degrees Kelvin.
  NoiseTemperature = 290;
  %NoiseFigure Noise figure
  %   Specify the noise figure in decibels relative to a noise temperature
  %   of 290 degrees Kelvin. You must set this property to a numeric,
  %   nonnegative, real scalar. This property applies when you set the
  %   NoiseMethod property to 'Noise figure'. The default is 3.01 decibels,
  %   which corresponds to a noise temperature of
  %   290*(10^(NoiseFigure/10)-1). This approximates 290 degrees Kelvin.
  NoiseFigure = 3.01;
  %NoiseFactor Noise factor
  %   Specify the noise factor as a factor relative to a noise temperature
  %   of 290 degrees Kelvin. You must set this property to a numeric, real
  %   scalar greater than or equal to 1. This property applies when you set
  %   the NoiseMethod property to 'Noise factor'. The default is 2, which
  %   corresponds to a noise temperature of 290*(NoiseFactor-1) = 290
  %   degrees Kelvin.
  NoiseFactor = 2;
  %SampleRate Sample rate
  %   Specify the sample rate of the input samples in Hz as a numeric, real,
  %   positive scalar. The object computes the variance of the noise added
  %   to the input signal as (kT*SampleRate). The value k is Boltzmann's
  %   constant and T is the noise temperature specified explicitly or
  %   implicitly via one of the noise methods. The default is 1.
  SampleRate = 1;
end

properties (Constant, Hidden)
  NoiseMethodSet = matlab.system.StringSet({...
    'Noise temperature','Noise figure','Noise factor'});
end

properties (Access = private)
  cAWGN;
end

methods
  function obj = ThermalNoise(varargin)
    setProperties(obj, nargin, varargin{:});

    obj.cAWGN = comm.AWGNChannel('NoiseMethod','Variance', ...
      'VarianceSource','Property');
  end
  
  function set.NoiseTemperature(obj,val)
    validateattributes( val,...
      {'numeric'},{'real','scalar','nonnegative'},'', 'NoiseTemperature'); %#ok<EMCA>
    obj.NoiseTemperature = val;
  end
  
  function set.NoiseFigure(obj,val)
    validateattributes( val,...
      {'numeric'},{'real','scalar','nonnegative'},'', 'NoiseFigure'); %#ok<EMCA>
    obj.NoiseFigure = val;
  end
  
  function set.NoiseFactor(obj,val)
    validateattributes( val,...
      {'numeric'},{'real','scalar','>=',1},'', 'NoiseFactor'); %#ok<EMCA>
    obj.NoiseFactor = val;
  end  
  
  function set.SampleRate(obj,val)
    validateattributes( val,...
      {'numeric'},{'real','scalar','positive'},'', 'SampleRate'); %#ok<EMCA>
    obj.SampleRate = val;
  end   
end

methods (Access=protected)  
  function y = stepImpl(obj, x)    
    y = step(obj.cAWGN,x);
  end
  
  function validateInputsImpl(~,x)
    coder.internal.errorIf(~iscolumn(x) || isempty(x), ...
      'MATLAB:system:inputMustBeColVector','X');
    coder.internal.errorIf(isreal(x), 'MATLAB:system:invalidComplexity', ...
      1, 'complex', 'real');
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
    
  function setupImpl(obj, ~)          
    k=1.380650e-23; % Boltzmann's constant

    switch obj.NoiseMethod
      case 'Noise temperature'
        temp = obj.NoiseTemperature;
      case 'Noise figure'
        nfactor = 10.^(0.1*obj.NoiseFigure);
        temp = 290*(nfactor-1);
      case 'Noise factor'
        temp = 290*(obj.NoiseFactor-1);
    end
    
    obj.cAWGN.Variance = k*temp*obj.SampleRate; %scale by sampling rate
  end
  
  function resetImpl(obj)
    reset(obj.cAWGN)
  end
  
  function releaseImpl(obj)
    release(obj.cAWGN)
  end
      
  function flag = isInactivePropertyImpl(obj, prop)
    flag = false;
    switch prop
      case 'NoiseTemperature'
        if ~strcmp(obj.NoiseMethod,'Noise temperature')
          flag = true;
        end
      case 'NoiseFigure'
        if ~strcmp(obj.NoiseMethod,'Noise figure')
          flag = true;
        end
      case 'NoiseFactor'
        if ~strcmp(obj.NoiseMethod,'Noise factor')
          flag = true;
        end
    end
  end  
  
  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      s.cAWGN = ...
        matlab.System.saveObject(obj.cAWGN);
    end
  end
  
  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      obj.cAWGN = ...
        matlab.System.loadObject(s.cAWGN);
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end
end % methods, protected API
end
