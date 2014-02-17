classdef DifferentialDecoder < matlab.System
%DifferentialDecoder Decode binary signal using differential decoding
%   H = comm.DifferentialDecoder returns a differential decoder System
%   object, H. This object decodes a binary input signal that was previously
%   encoded using a differential encoder.
%
%   H = comm.DifferentialDecoder(Name,Value) creates a differential decoder
%   object, H, with the specified property Name set to the specified Value.
%
%   H = comm.DifferentialDecoder(INITCOND) creates a differential decoder
%   object, H,  with the InitialCondition property set to INITCOND.
% 
%   Step method syntax:
%
%   Y = step(H,X) decodes the differentially encoded input data, X, and
%   returns the decoded data, Y. The input X must be a scalar, vector, or
%   matrix of data type logical, numeric, or fixed-point (embedded.fi
%   objects). When the input is a matrix or a row vector, the object treats
%   each column as a separate channel. Y has the same data type as X. The
%   object treats non-binary inputs as binary signals. The object computes
%   the initial output value by performing an Xor operation of the value in
%   the InitialCondition property and the first element of the vector you
%   input the first time you call the step method.
%
%   DifferentialDecoder methods:
%
%   step     - Decode input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create differential decoder object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of differential decoder object
%
%   DifferentialDecoder properties:
%
%   InitialCondition  - Initial value used to generate initial output
%
%   % Example: 
%   %   Decode a differentially encoded signal
%
%   % Create Differential Encoder System object
%   hdiffenc = comm.DifferentialEncoder;
%   % Create Differential Decoder System object
%   hdiffdec = comm.DifferentialDecoder;
%   % Generate random binary data
%   data = randi([0 1], 100, 1);
%   % Encode data
%   encdata = step(hdiffenc,data);
%   % Decode data
%   recdata = step(hdiffdec, encdata);
%   errors = biterr(data, recdata);
%   fprintf(1, ['\nThere were %d errors in the decoded signal ' ...
%               'out of %d bits\n'],errors, length(data));
%     
%   See also comm.DifferentialEncoder.

%   Copyright 2010-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.9 $ $Date: 2012/04/14 03:41:44 $

%#codegen
%#ok<*EMCLS>
 
properties (Nontunable)
  %InitialCondition Initial value used to generate initial output
  %   Specify the initial condition as a real scalar. The data type can be
  %   logical, numeric, or fixed-point (embedded.fi object). The object
  %   treats non-binary values as binary signals, interpreting non-zero
  %   values as 1. The default is 0.
  InitialCondition = 0
end

properties(Access = private)
  pLastValue   % Store last value of previous input
  pYAttributes % Store attributes of output buffer as another buffer
end

methods
  % CONSTRUCTOR
  function obj = DifferentialDecoder(varargin)
    setProperties(obj, nargin, varargin{:}, 'InitialCondition');
  end
  
  % set properties validation
  function set.InitialCondition(obj, value)
    validateattributes( value, { 'numeric', 'logical', 'embedded.fi' }, ...
      { 'real', 'scalar' }, '', 'InitialCondition'); %#ok<EMCA>
    obj.InitialCondition = value;
  end
end

methods(Access = protected)   
  function validateInputsImpl(~, x)   
    if ~ismatrix(x) || isempty(x)
      matlab.system.internal.error(...
        'MATLAB:system:inputMustBeMatrix','X');
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
    % Set size and type from input. Buffers are initialized to 0.
    sz = size(x);
    obj.pLastValue   = ...
      comm.DifferentialDecoder.getAttributesFromInput([1 sz(2)], x);
    obj.pYAttributes = ...
      comm.DifferentialDecoder.getAttributesFromInput(sz, x);
  end
  
  function y = stepImpl(obj, x)
    % Cast (xor output is logical) into output temp.
    obj.pYAttributes(:) = xor(x,[obj.pLastValue; x(1:end-1,:)]);
    % Copy to output.
    y = obj.pYAttributes;
    % Cast to remove input fimath
    obj.pLastValue(:) = x(end,:); % save last input value
    % Single last value, since this is frame based single channel.
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
