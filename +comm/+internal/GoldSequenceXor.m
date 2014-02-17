classdef (Hidden) GoldSequenceXor < matlab.System %#ok<EMCLS>
%GoldSequenceXor Gold sequence generation engine for the public GoldSequence
%System object
%   H = comm.internal.GoldSequenceXor creates a Gold sequence generator that
%   performs an XOR operation on outputs of two PN sequence System objects.
  
%   Copyright 2010-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.11 $ $Date: 2012/04/14 03:42:44 $
    
%#codegen
 
properties (Hidden, Nontunable)     
  %FirstPolynomial Generator polynomial for first preferred PN sequence
  FirstPolynomial = [1 0 0 0 0 1 1];
  %FirstInitialConditions Initial conditions for first PN sequence generator
  FirstInitialConditions = [0 0 0 0 0 1];
  %SecondPolynomial Generator polynomial for second preferred PN sequence
  SecondPolynomial = [1 1 0 0 1 1 1];
  %SecondInitialConditionsSource Source of initial conditions for second
  %                              PN sequence
  SecondInitialConditionsSource = 'Property';
  %SecondInitialConditions Initial conditions for second PN sequence
  SecondInitialConditions = [0 0 0 0 0 1];
  %Index Index of output sequence of interest
  Index = 0;
  %Shift Sequence offset from initial time
  Shift = 0;
  %MaximumOutputSize Maximum output size
  MaximumOutputSize = [10 1];
  %SamplesPerFrame Number of output samples per frame
  SamplesPerFrame = 1;
end

properties (Hidden, Nontunable)
  %VariableSizeOutput Enable variable size output
  VariableSizeOutput = false;
  %ResetInputPort Enable reset via input argument
  ResetInputPort = false;
  %OutputDataType Data type of output
  OutputDataType = 'double';
end

properties (Access=private)
  %pFirstSequence First PN sequence generator System object
  pFirstSequence;
  %pSecondSequence Second PN sequence generator System object
  pSecondSequence;
end

properties (Constant, Hidden)
    SecondInitialConditionsSourceSet = comm.CommonSets.getSet('SpecifyInputs');
end

methods
  function this = GoldSequenceXor(varargin)
    setProperties(this, nargin, varargin{:});
  end
end
  
methods(Access = protected)
  function setupImpl(obj, varargin)
      % Create the fully configured objects. For codegen, no subsequent
      % sets allowed
      if obj.VariableSizeOutput
          if strcmp(obj.SecondInitialConditionsSource, 'Property')
              obj.pFirstSequence = comm.PNSequence(...
                  'Polynomial',         obj.FirstPolynomial, ...
                  'InitialConditions',  obj.FirstInitialConditions, ...
                  'MaskSource',         'Property', ...
                  'Mask',               obj.Shift, ...
                  'VariableSizeOutput', obj.VariableSizeOutput, ...
                  'MaximumOutputSize',  obj.MaximumOutputSize, ...
                  'ResetInputPort',     obj.ResetInputPort,...
                  'OutputDataType',    'double');
              
              obj.pSecondSequence = comm.PNSequence(...
                  'Polynomial',         obj.SecondPolynomial, ...
                  'InitialConditionsSource',  'Property', ...
                  'InitialConditions', obj.SecondInitialConditions,...
                  'MaskSource',         'Property', ...
                  'Mask',               obj.Shift + obj.Index, ...
                  'VariableSizeOutput', obj.VariableSizeOutput, ...
                  'MaximumOutputSize',  obj.MaximumOutputSize, ...
                  'ResetInputPort',     obj.ResetInputPort,...
                  'OutputDataType',    'double');
          else % input port
              % reset always on
              obj.pFirstSequence = comm.PNSequence(...
                  'Polynomial',         obj.FirstPolynomial, ...
                  'InitialConditions',  obj.FirstInitialConditions, ...
                  'MaskSource',         'Property', ...
                  'Mask',               obj.Shift, ...
                  'VariableSizeOutput', obj.VariableSizeOutput, ...
                  'MaximumOutputSize',  obj.MaximumOutputSize, ...
                  'ResetInputPort',     true,...
                  'OutputDataType',    'double');
              
              obj.pSecondSequence = comm.PNSequence(...
                  'Polynomial',         obj.SecondPolynomial, ...
                  'InitialConditionsSource',  obj.SecondInitialConditionsSource, ...
                  'MaskSource',         'Property', ...
                  'Mask',               obj.Shift + obj.Index, ...
                  'VariableSizeOutput', obj.VariableSizeOutput, ...
                  'MaximumOutputSize',  obj.MaximumOutputSize, ...
                  'OutputDataType',    'double');
          end
      else % not variable-size
          if strcmp(obj.SecondInitialConditionsSource, 'Property')
              obj.pFirstSequence = comm.PNSequence(...
                  'Polynomial',         obj.FirstPolynomial, ...
                  'InitialConditions',  obj.FirstInitialConditions, ...
                  'MaskSource',         'Property', ...
                  'Mask',               obj.Shift, ...
                  'VariableSizeOutput', obj.VariableSizeOutput, ...
                  'SamplesPerFrame',    obj.SamplesPerFrame, ...
                  'ResetInputPort',     obj.ResetInputPort,...
                  'OutputDataType',     'double');
              
              obj.pSecondSequence = comm.PNSequence(...
                  'Polynomial',         obj.SecondPolynomial, ...
                  'InitialConditionsSource',  'Property', ...
                  'InitialConditions', obj.SecondInitialConditions,...
                  'MaskSource',         'Property', ...
                  'Mask',               obj.Shift + obj.Index, ...
                  'VariableSizeOutput', obj.VariableSizeOutput, ...
                  'SamplesPerFrame',    obj.SamplesPerFrame, ...
                  'ResetInputPort',     obj.ResetInputPort,...
                  'OutputDataType',     'double');
          else % input port
              obj.pFirstSequence = comm.PNSequence(...
                  'Polynomial',         obj.FirstPolynomial, ...
                  'InitialConditions',  obj.FirstInitialConditions, ...
                  'MaskSource',         'Property', ...
                  'Mask',               obj.Shift, ...
                  'VariableSizeOutput', obj.VariableSizeOutput, ...
                  'SamplesPerFrame',    obj.SamplesPerFrame, ...
                  'ResetInputPort',     true,...
                  'OutputDataType',     'double');
              
              obj.pSecondSequence = comm.PNSequence(...
                  'Polynomial',         obj.SecondPolynomial, ...
                  'InitialConditionsSource',  obj.SecondInitialConditionsSource, ...
                  'MaskSource',         'Property', ...
                  'Mask',               obj.Shift + obj.Index, ...
                  'VariableSizeOutput', obj.VariableSizeOutput, ...
                  'SamplesPerFrame',    obj.SamplesPerFrame, ...
                  'OutputDataType',     'double');
          end
      end
  end

  function out = stepImpl(obj, varargin)
    if strcmp(obj.SecondInitialConditionsSource, 'Input port')
        % A non-empty varargin contains either the [secondInit] or [secondInit
        % and input outsize]
        % Always reset the first sequence
        if obj.VariableSizeOutput            
            outTemp = xor(step(obj.pFirstSequence, varargin{2}, 1), ...
                          step(obj.pSecondSequence, varargin{:})); 
        else
            outTemp = xor(step(obj.pFirstSequence, 1), ...
                          step(obj.pSecondSequence, varargin{:})); 
        end
    else
        % A non-empty varargin contains the input outputsize and/or reset signal
        outTemp = xor(step(obj.pFirstSequence, varargin{:}), ...
                      step(obj.pSecondSequence, varargin{:})); 
    end
    % Upcast data type
    switch obj.OutputDataType
      case 'Smallest unsigned integer'    
        out = castToFi(outTemp);
      case 'double'
        out = castToDouble(outTemp);
      otherwise
        out = outTemp;
    end    
  end  
  
  function num = getNumInputsImpl(obj)
    num = obj.VariableSizeOutput + (obj.ResetInputPort || ...
          strcmp(obj.SecondInitialConditionsSource, 'Input port'));
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
    
  function resetImpl(obj)
    reset(obj.pFirstSequence)
    reset(obj.pSecondSequence)
  end
  
  function flag = isInactivePropertyImpl(obj, prop)
    flag = false;
    switch prop
      case 'SecondInitialConditions'
        if strcmp(obj.SecondInitialConditionsSource, 'Input port')
          flag = true;
        end
      case 'ResetInputPort'
        if strcmp(obj.SecondInitialConditionsSource, 'Input port')
          flag = true;
        end
    end
  end

  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      s.pFirstSequence = matlab.System.saveObject(obj.pFirstSequence);
      s.pSecondSequence = matlab.System.saveObject(obj.pSecondSequence);
    end
  end
  
  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      obj.pFirstSequence = matlab.System.loadObject(s.pFirstSequence);
      obj.pSecondSequence = matlab.System.loadObject(s.pSecondSequence);
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end
end
end

% Helper functions
function output = castToFi(input)
  output = fi(int8(input),0,1,0);
end

function output = castToDouble(input)
  output = double(input);
end
