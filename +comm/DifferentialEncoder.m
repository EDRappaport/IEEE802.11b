classdef DifferentialEncoder < matlab.System
%DifferentialEncoder Encode binary signal using differential coding
%   H = comm.DifferentialEncoder creates a differential encoder System
%   object, H. This object encodes a binary input signal by calculating its
%   logical difference with the previously encoded data.
%
%   H = comm.DifferentialEncoder(Name,Value) creates a differential encoder
%   object, H, with the specified property Name set to the specified Value.
%
%   H = comm.DifferentialEncoder(INITCOND) creates a differential encoder
%   object, H, with the InitialCondition property set to INITCOND.
%
%   Step method syntax:
%
%   Y = step(H,X) encodes the binary input data, X, and returns the
%   differentially encoded data, Y. The input X must be a scalar, vector, or
%   matrix of data type logical, numeric, or fixed-point (embedded.fi
%   objects). When the input is a matrix, the object treats each column as a
%   separate channel. Y has the same data type as X. The object treats
%   non-binary inputs as binary signals. The object computes the initial
%   output value by performing an Xor operation of the value in the
%   InitialCondition property and the first element of the vector you input
%   the first time you call the step method.
%
%   DifferentialEncoder methods:
%
%   step     - Encode input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create differential encoder object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of differential encoder object
%
%   DifferentialEncoder properties:
%
%   InitialCondition - Initial value used to generate initial output
%
%   % Example: 
%   %   Encode binary signal using differential coding
%
%   % Create Differential Encoder System object
%   hdiffenc = comm.DifferentialEncoder;
%   % Generate random binary data
%   data = randi([0 1], 11, 1);
%   % Encode data
%   encdata = step(hdiffenc,data);
%
%   See also comm.DifferentialDecoder.

%   Copyright 2010-2012 The MathWorks, Inc.

%#codegen
%#ok<*EMCLS>

properties (Nontunable)
  %InitialCondition Initial value used to generate initial output
  %   Specify the initial condition as a real scalar. The data type can be
  %   logical, numeric, or fixed-point (embedded.fi object). The object
  %   treats non-binary values as binary signals. The default is 0.
  InitialCondition = 0;
end

properties(Access = private)
  pLastValue   % Store last value of previous output
  pYAttributes % Store attributes of output buffer as another buffer
end

methods
  % CONSTRUCTOR
  function obj = DifferentialEncoder(varargin)
    setProperties(obj, nargin, varargin{:}, 'InitialCondition');
  end
  
  % set properties validation
  function set.InitialCondition(obj, value)
    validateattributes( value, { 'numeric', 'logical', 'embedded.fi' }, { 'real', 'scalar' }, '', 'InitialCondition'); %#ok<EMCA>
    obj.InitialCondition = value;
  end
end

methods(Access = protected)   
  function validateInputsImpl(~,x)   
    if ~iscolumn(x) || isempty(x)
      matlab.system.internal.error(...
        'MATLAB:system:inputMustBeColVector','X');
    end
    coder.internal.errorIf(~isreal(x), 'comm:sysObj:inputNotReal');
    
    if isa(x, 'embedded.fi')
      if (get(x,'WordLength')-get(x,'FractionLength')-get(x,'Signed')) < 1
        if get(x,'Signed')
          coder.internal.errorIf(true, 'comm:system:DifferentialEncoding:InvalidSignedFiInput');
        else
          coder.internal.errorIf(true, 'comm:system:DifferentialEncoding:InvalidUnsignedFiInput');
        end
      end
    end
  end
  
  function resetImpl(obj)
%   Note: State buffer WILL have same dtype and complexity as input.
%   Initial condition may not, so a cast is necessary
    obj.pLastValue(:) = obj.InitialCondition;
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
    sz = size(x);
    % Set size and type from input. Buffers are initialized to 0.
    obj.pLastValue   = ...
      comm.DifferentialEncoder.getAttributesFromInput([1 sz(2)], x);
    obj.pYAttributes = ...
      comm.DifferentialEncoder.getAttributesFromInput(sz, x);
  end
  
  function y = stepImpl(obj, x)
    sz = size(x);
    y = obj.pYAttributes;
    % Cast (xor output is logical) into output temp.
    y(1,:) = xor(obj.pLastValue,x(1,:));
    for q = 2:sz(1)
      y(q) = xor(y(q-1,:),x(q,:));
    end
    
    obj.pLastValue(:) = y(end,:);  % save last output value
  end
  
  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      s.pLastValue = obj.pLastValue;
      s.pYAttributes = obj.pYAttributes;
    end
  end
  
  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      obj.pLastValue = s.pLastValue;
      obj.pYAttributes = s.pYAttributes;
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
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
