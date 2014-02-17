classdef GoldSequence < matlab.System
%GoldSequence Generate a Gold sequence
%   H = comm.GoldSequence creates a Gold sequence generator System object,
%   H, that generates a pseudo-random Gold sequence.
%
%   H = comm.GoldSequence(Name,Value) creates a Gold sequence generator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H) outputs a frame of the Gold sequence in column vector Y.
%   Specify the frame length with the SamplesPerFrame property. The object
%   uses two PN sequence generators to generate a preferred pair of
%   sequences with period N = 2^n-1. Then the object XORs these sequences to
%   produce the output Gold sequence.  The value in n is the degree of the
%   generator polynomials that you specify in the FirstPolynomial and
%   SecondPolynomial properties.
%
%   Y = step(H,SECINITCOND) uses SECINITCOND as the initial conditions for
%   the second PN sequence when you set the SecondInitialConditionsSource
%   property to 'Input port'. SECINITCOND must be a numeric scalar or a
%   numeric, binary vector with length equal to the degree of the second
%   generator polynomial specified in the SecondPolynomial property.
%
%   Y = step(H,OUTPUTSIZE) uses OUTPUTSIZE as the output size for the
%   current step when you set the VariableSizeOutput property to true. The
%   OUTPUTSIZE input must be a non-negative integer scalar or 2-element row
%   vector. The scalar or the first element of the row vector must be
%   less than or equal to the first element of MaximumOutputSize property
%   value. The second element of the OUTPUTSIZE row vector input must be 1.
%
%   Y = step(H,RESET) uses RESET as the reset signal when you set the
%   ResetInputPort property to true. The data type of the RESET input must
%   be double precision or logical. RESET can be a scalar value or a column
%   vector with length equal to the number of samples per frame specified in
%   the SamplesPerFrame property. When the RESET input is a non-zero scalar,
%   the object resets to the initial conditions that you specify in the
%   FirstInitialConditions and SecondInitialConditions properties. It then
%   generates a new output frame. A column vector RESET input allows
%   multiple resets within an output frame. A non-zero value at the ith
%   element of the vector causes a reset at the ith output sample time.
%
%   You can combine optional input arguments when you set their enabling
%   properties. Optional inputs must be listed in the same order as the
%   order of the enabling properties. For example,
%
%   Y = step(H, SECINITCOND, OUTPUTSIZE) or Y = step(H, OUTPUTSIZE, RESET)
%
%   GoldSequence methods:
%
%   step     - Generate Gold sequence samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Gold sequence generator object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of Gold sequence generator object
%
%   GoldSequence properties:
%
%   FirstPolynomial               - Generator polynomial for first preferred 
%                                   PN sequence
%   FirstInitialConditions        - Initial conditions for first PN sequence 
%                                   generator
%   SecondPolynomial              - Generator polynomial for second preferred PN
%                                   sequence
%   SecondInitialConditionsSource - Source of initial conditions for second
%                                   PN sequence
%   SecondInitialConditions       - Initial conditions for second PN sequence
%                                   generator
%   Index                         - Index of output sequence of interest
%   Shift                         - Sequence offset from initial time
%   VariableSizeOutput            - Enable variable-size outputs
%   MaximumOutputSize             - Maximum output size
%   SamplesPerFrame               - Number of output samples per frame
%   ResetInputPort                - Enable generator reset input
%   OutputDataType                - Data type of output
%
%   % Example:
%   %   Get 10 samples of a Gold sequence of period 2^5-1
%
%   hgld = comm.GoldSequence('FirstPolynomial',[5 2 0],...
%            'SecondPolynomial', [5 4 3 2 0],...
%            'FirstInitialConditions', [0 0 0 0 1],...
%            'SecondInitialConditions', [0 0 0 0 1],...
%            'Index', 4, 'SamplesPerFrame', 10);
%   x = step(hgld)
%
%   See also comm.KasamiSequence, comm.PNSequence.

%   Copyright 2008-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.12 $ $Date: 2012/04/14 03:41:50 $

%#codegen
%#ok<*EMCLS>

properties (Nontunable)     
  %FirstPolynomial Generator polynomial for first preferred PN sequence
  %   Specify the polynomial that determines the feedback connections for
  %   the shift register of the first preferred PN sequence generator. You
  %   can specify the generator polynomial as a numeric, binary vector that
  %   lists the coefficients of the polynomial in descending order of
  %   powers. The first and last elements must be equal to 1 and the length
  %   of this vector must be n+1, where n is the degree of the generator
  %   polynomial. Alternatively, you can specify the generator polynomial as
  %   a numeric vector containing the exponents of z for the non-zero terms
  %   of the polynomial in descending order of powers. The last entry must
  %   be 0. For example, [1 0 0 0 0 0 1 0 1] and [8 2 0] represent the same
  %   polynomial, g(z) = z^8 + z^2 + 1. The degree of the first generator
  %   polynomial must be equal to the degree of the second generator
  %   polynomial specified in the SecondPolynomial property. The default is
  %   [1 0 0 0 0 1 1].
  FirstPolynomial = [1 0 0 0 0 1 1];
  %FirstInitialConditions Initial conditions for first PN sequence generator
  %   Specify the initial conditions for the shift register of the first
  %   preferred PN sequence generator. The initial conditions are a numeric,
  %   binary scalar, or a numeric, binary vector with length equal to the
  %   degree of the first generator  polynomial specified in the
  %   FirstPolynomial property. If you set this property to a vector, each
  %   element of the vector corresponds to the initial value of the
  %   corresponding cell in the shift register. If you set this property to
  %   a scalar, the initial conditions of all shift register cells are the
  %   specified scalar value. The default is [0 0 0 0 0 1].
  FirstInitialConditions = [0 0 0 0 0 1];
  %SecondPolynomial Generator polynomial for second preferred PN sequence
  %   Specify the polynomial that determines the feedback connections for
  %   the shift register of the second preferred PN sequence generator. You
  %   can specify the generator polynomial as a binary, numeric vector that
  %   lists the coefficients of the polynomial in descending order of
  %   powers. The first and last elements must be equal to 1 and the length
  %   of this vector must be n+1, where n is the degree of the generator
  %   polynomial. Alternatively, you can specify the generator polynomial as
  %   a numeric vector containing the exponents of z for the nonzero terms
  %   of the polynomial in descending order of powers. The last entry must
  %   be 0. For example, [1 0 0 0 0 0 1 0 1] and [8 2 0] represent the same
  %   polynomial, g(z) = z^8 + z^2 + 1. The degree of the second generator
  %   polynomial must equal the degree of the first generator polynomial
  %   specified in the FirstPolynomial property. The default is [1 1 0 0 1 1
  %   1].
  SecondPolynomial = [1 1 0 0 1 1 1];
  %SecondInitialConditionsSource Source of initial conditions for second PN
  %                              sequence
  %   Specify the source of the initial conditions that determines the
  %   start of the second PN sequence as one of  'Property' | 'Input port'.
  %   The default is 'Property'. When you set this property to 'Property',
  %   the initial conditions can be specified as a scalar or binary vector
  %   using the SecondInitialConditions property. When you set this
  %   property to 'Input port', the initial conditions, which is an input
  %   to the step method, can be specified as a binary scalar or a binary
  %   vector with a length equal to the degree of the generator polynomial
  %   specified by the SecondPolynomial property.
  SecondInitialConditionsSource = 'Property';
  %SecondInitialConditions Initial conditions for second PN sequence
  %                        generator
  %   Specify the initial conditions for the shift register of the second
  %   preferred PN sequence generator as a numeric, binary scalar, or as a
  %   numeric, binary vector with length equal to the degree of the second
  %   generator polynomial specified in the SecondPolynomial property. If
  %   you set this property to a vector, each element of the vector
  %   corresponds to the initial value of the corresponding cell in the
  %   shift register. If you set this property to a scalar, the initial
  %   conditions of all shift register cells are the specified scalar value.
  %   The default is [0 0 0 0 0 1].
  SecondInitialConditions = [0 0 0 0 0 1];
  %Index Index of output sequence of interest
  %   Specify the index of the output sequence of interest from the set of
  %   available sequences as a scalar integer in the range [-2, 2^n-2]. n is
  %   the degree of the generator polynomials you specify in the
  %   FirstPolynomial and SecondPolynomial properties. The index values -2
  %   and -1 correspond to the first and second preferred PN sequences as
  %   generated by the FirstPolynomial and SecondPolynomial, respectively.
  %
  %   The set G(u, v) of available Gold sequences is defined by G(u, v) =
  %   {u, v, (u xor T^v), (u xor T^2v), ..., (u xor T^(N-1)v)}, where T
  %   represents the operator that shifts vectors cyclically to the left by
  %   one place, and u, v are two preferred PN sequences. Note that G(u,v)
  %   contains N+2 Gold sequences of period N. You select the desired
  %   sequence from this set using the Index property. The default is 0.
  Index = 0;
  %Shift Sequence offset from initial time
  %   Specify the offset of the Gold sequence from its starting point as a
  %   positive or negative, numeric, integer scalar. The Gold sequence has a
  %   period of N = 2^n-1, where n is the degree of the generator
  %   polynomials specified in the FirstPolynomial and SecondPolynomial
  %   properties. The shift value is wrapped with respect to the sequence
  %    period. The default is 0.
  Shift = 0;
end

properties (Nontunable, Logical)
  %VariableSizeOutput Enable variable-size outputs
  %   Set this property to true to enable an additional input to the step
  %   method. The default is false. When you set this property to true, the
  %   enabled input specifies the output size of the Gold sequence used for
  %   the step. The input value must be less than or equal to the value of
  %   the MaximumOutputSize property.
  %   
  %   When you set this property to false, the SamplesPerFrame property
  %   specifies the number of output samples.
  VariableSizeOutput = false;
end

properties (Nontunable)   
  %MaximumOutputSize Maximum output size
  %   Specify the maximum output size of the Gold sequence as a positive
  %   integer 2-element row vector. The second element of the vector must
  %   be 1. The default is [10 1].
  %
  %   This property applies when you set the VariableSizeOutput property to
  %   true.
  MaximumOutputSize = [10 1];
  %SamplesPerFrame Number of output samples per frame
  %   Specify the number of Gold sequence samples that the step method
  %   outputs as a numeric, integer scalar. If you set this property to a
  %   value of M, then the step method outputs M samples of a Gold sequence
  %   that has a period of N = 2^n-1. The value of n represents the degree
  %   of the generator polynomials that you specify in the FirstPolynomial
  %   and SecondPolynomial properties. The default is 1.
  SamplesPerFrame = 1;
end

properties (Nontunable, Logical)  
  %ResetInputPort Enable generator reset input
  %   Set this property to true to enable an additional reset input to the
  %   step method. This input resets the states of the two shift registers
  %   of the Gold sequence generator to the initial conditions specified in
  %   the FirstInitialConditions and SecondInitialConditions properties. The
  %   default is false.
  ResetInputPort = false;
end

properties (Nontunable)  
  %OutputDataType Data type of output
  %   Specify the output data type as one of 'double' | 'logical' |
  %   'Smallest unsigned integer'. The default is 'double'.
  OutputDataType = 'double';
end

properties (Constant, Hidden)
    SecondInitialConditionsSourceSet = comm.CommonSets.getSet('SpecifyInputs');
    OutputDataTypeSet = comm.CommonSets.getSet(...
    'DoubleLogicalSmallestUnsigned');
end

properties (Access = private, Nontunable)
  cGenerator;
end

methods
  function obj = GoldSequence(varargin)
    setProperties(obj, nargin, varargin{:});
  end
  
  function set.FirstPolynomial(obj,val)
    validateattributes( val, { 'numeric' }, ...
      { 'real', 'integer', 'nonnegative', 'vector' }, '', ...
      'FirstPolynomial');%#ok<EMCA>
    obj.FirstPolynomial = val;
  end
  
  function set.FirstInitialConditions(obj,val)
    validateattributes( val, { 'numeric' }, ...
      { 'binary', 'vector' }, '', 'FirstInitialConditions');%#ok<EMCA>
    obj.FirstInitialConditions = val;
  end
  
  function set.SecondPolynomial(obj,val)
    validateattributes( val, { 'numeric' }, ...
      { 'real', 'integer', 'nonnegative', 'vector' }, '', ...
      'SecondPolynomial');%#ok<EMCA>
    obj.SecondPolynomial = val;
  end
  
  function set.SecondInitialConditions(obj,val)
    validateattributes( val, { 'numeric' }, ...
      { 'binary', 'vector' }, '', 'SecondInitialConditions');%#ok<EMCA>
    obj.SecondInitialConditions = val;
  end  
  
  function set.Index(obj,val)
    validateattributes( val, { 'numeric' }, ...
      { 'integer', 'scalar', '>=', -2 }, '', 'Index');%#ok<EMCA>
    obj.Index = val;    
  end

  function set.Shift(obj,val)
    validateattributes( val, { 'numeric' }, ...
      { 'integer', 'scalar' }, '', 'Shift');%#ok<EMCA>
    obj.Shift = val;    
  end  
  
  function set.SamplesPerFrame(obj,val)
    validateattributes( val, { 'numeric' }, ...
      { 'integer', 'positive', 'scalar' }, '', 'SamplesPerFrame');%#ok<EMCA>
    obj.SamplesPerFrame = val;    
  end    
end

methods(Access = protected)
  function out = stepImpl(obj, varargin)
    % A non-empty varargin contains either the [input outputsize and/or
    % reset signal] or [secondInit and/or input outputsize]
    out = step(obj.cGenerator, varargin{:});
  end
  
  function setupImpl(obj, varargin)
    % Validate reset input port dimensions
    if ( obj.ResetInputPort && strcmp(obj.SecondInitialConditionsSource, 'Property') )
      if ~obj.VariableSizeOutput
        sz = size(varargin{1});
        if any(sz > 1) && any(sz ~= [obj.SamplesPerFrame 1])
          coder.internal.errorIf(true, 'comm:system:GoldSequence:invalidInputRESETDims', obj.SamplesPerFrame);
        end
      else % with varSize
        sz = size(varargin{2});
        coder.internal.errorIf( any(sz > 1), 'comm:system:GoldSequence:invalidInputRESETDimsVarS');
      end
    end
    
    % Validate generator polynomials, initial conditions, and code index
    firstBinaryPoly = ...
      checkPNSequenceInputs(obj, obj.FirstPolynomial, obj.Shift);
    secondBinaryPoly = ...
      checkPNSequenceInputs(obj, obj.SecondPolynomial, obj.Shift);
    
    degree1 = length(firstBinaryPoly)-1;
    degree2 = length(secondBinaryPoly)-1;
    coder.internal.errorIf(degree1 ~= degree2, 'comm:system:GoldSequence:invalidPolynomialDegrees');    
    coder.internal.errorIf(obj.Index > 2^degree1-2, 'comm:system:GoldSequence:invalidIndex');
    
    if length(obj.FirstInitialConditions) ~= degree1 && ...
        ~isscalar(obj.FirstInitialConditions)
      coder.internal.errorIf(true, 'comm:system:GoldSequence:invalidFirstInitialConditions');
    end
    
    if strcmp(obj.SecondInitialConditionsSource, 'Property')
        if length(obj.SecondInitialConditions) ~= degree2 && ...
            ~isscalar(obj.SecondInitialConditions)
          coder.internal.errorIf(true, 'comm:system:GoldSequence:invalidSecondInitialConditions');
        end
    end
    
    % Instantiate generator objects.  For codegen support, can only
    % construct fully configured objects, no subsequent sets allowed.
    % If Sequence index is negative it means the user wants the first or
    % second PN sequence as an output
    if obj.Index < 0
        if obj.Index == -2
            % Output first sequence only
            poly = obj.FirstPolynomial;
            initStates = obj.FirstInitialConditions;
            if obj.VariableSizeOutput
                obj.cGenerator = comm.PNSequence(...
                    'Polynomial',         poly, ...
                    'InitialConditions',  initStates, ...
                    'MaskSource',         'Property', ...
                    'Mask',               obj.Shift, ...
                    'VariableSizeOutput', obj.VariableSizeOutput, ...
                    'MaximumOutputSize',  obj.MaximumOutputSize, ...
                    'ResetInputPort',     obj.ResetInputPort,...
                    'OutputDataType',     obj.OutputDataType);
            else
                obj.cGenerator = comm.PNSequence(...
                    'Polynomial',         poly, ...
                    'InitialConditions',  initStates, ...
                    'MaskSource',         'Property', ...
                    'Mask',               obj.Shift, ...
                    'VariableSizeOutput', obj.VariableSizeOutput, ...
                    'SamplesPerFrame',    obj.SamplesPerFrame, ...
                    'ResetInputPort',     obj.ResetInputPort,...
                    'OutputDataType',     obj.OutputDataType);
            end
            % Do not allow second init conditions from input when only
            % first sequence is output
            if strcmp(obj.SecondInitialConditionsSource, 'Input port')
                coder.internal.errorIf(true, 'comm:system:GoldSequence:invalidIndexInitCond');
            end
        else
            % Output second sequence only
            poly = obj.SecondPolynomial;
            initStatesSrc = obj.SecondInitialConditionsSource;
            
            if obj.VariableSizeOutput
                if strcmp(obj.SecondInitialConditionsSource, 'Property')
                    obj.cGenerator = comm.PNSequence(...
                        'Polynomial',         poly, ...
                        'InitialConditionsSource',  'Property', ...                    
                        'InitialConditions',  obj.SecondInitialConditions,...
                        'MaskSource',         'Property', ...
                        'Mask',               obj.Shift, ...
                        'VariableSizeOutput', obj.VariableSizeOutput, ...
                        'MaximumOutputSize',  obj.MaximumOutputSize, ...
                        'ResetInputPort',     obj.ResetInputPort,...
                        'OutputDataType',     obj.OutputDataType);
                else % input port
                    obj.cGenerator = comm.PNSequence(...
                        'Polynomial',         poly, ...
                        'InitialConditionsSource',  initStatesSrc, ...                    
                        'MaskSource',         'Property', ...
                        'Mask',               obj.Shift, ...
                        'VariableSizeOutput', obj.VariableSizeOutput, ...
                        'MaximumOutputSize',  obj.MaximumOutputSize, ...
                        'OutputDataType',     obj.OutputDataType);                    
                end
            else % no varsize
                if strcmp(obj.SecondInitialConditionsSource, 'Property')
                    obj.cGenerator = comm.PNSequence(...
                        'Polynomial',         poly, ...
                        'InitialConditionsSource', 'Property', ...
                        'InitialConditions', obj.SecondInitialConditions,...
                        'MaskSource',         'Property', ...
                        'Mask',               obj.Shift, ...
                        'VariableSizeOutput', obj.VariableSizeOutput, ...
                        'SamplesPerFrame',    obj.SamplesPerFrame, ...
                        'ResetInputPort',     obj.ResetInputPort,...
                        'OutputDataType',     obj.OutputDataType);
                else % input port
                    obj.cGenerator = comm.PNSequence(...
                        'Polynomial',         poly, ...
                        'InitialConditionsSource',  initStatesSrc, ...
                        'MaskSource',         'Property', ...
                        'Mask',               obj.Shift, ...
                        'VariableSizeOutput', obj.VariableSizeOutput, ...
                        'SamplesPerFrame',    obj.SamplesPerFrame, ...
                        'OutputDataType',     obj.OutputDataType);                    
                end
            end
        end      
     else
      % Output a Gold sequence. For faster performance let cGenerator do the
      % data casting and set the output data type of the generators to
      % 'double'.
      if obj.VariableSizeOutput
          if strcmp(obj.SecondInitialConditionsSource, 'Property')
              obj.cGenerator = comm.internal.GoldSequenceXor(...
                  'FirstPolynomial',               obj.FirstPolynomial, ...
                  'FirstInitialConditions',        obj.FirstInitialConditions, ...
                  'SecondPolynomial',              obj.SecondPolynomial, ...
                  'SecondInitialConditionsSource', 'Property', ...
                  'SecondInitialConditions',       obj.SecondInitialConditions,...
                  'Shift',                         obj.Shift, ...
                  'Index',                         obj.Index, ...
                  'VariableSizeOutput',            obj.VariableSizeOutput, ...
                  'MaximumOutputSize',             obj.MaximumOutputSize, ...
                  'ResetInputPort',                obj.ResetInputPort,...
                  'OutputDataType',                obj.OutputDataType);              
          else
              obj.cGenerator = comm.internal.GoldSequenceXor(...
                  'FirstPolynomial',               obj.FirstPolynomial, ...
                  'FirstInitialConditions',        obj.FirstInitialConditions, ...
                  'SecondPolynomial',              obj.SecondPolynomial, ...
                  'SecondInitialConditionsSource', obj.SecondInitialConditionsSource, ...
                  'Shift',                         obj.Shift, ...
                  'Index',                         obj.Index, ...
                  'VariableSizeOutput',            obj.VariableSizeOutput, ...
                  'MaximumOutputSize',             obj.MaximumOutputSize, ...
                  'OutputDataType',                obj.OutputDataType);              
          end
      else
          if strcmp(obj.SecondInitialConditionsSource, 'Property')
              obj.cGenerator = comm.internal.GoldSequenceXor(...
                  'FirstPolynomial',               obj.FirstPolynomial, ...
                  'FirstInitialConditions',        obj.FirstInitialConditions, ...
                  'SecondPolynomial',              obj.SecondPolynomial, ...
                  'SecondInitialConditionsSource', 'Property', ...
                  'SecondInitialConditions',       obj.SecondInitialConditions,...
                  'Shift',                         obj.Shift, ...
                  'Index',                         obj.Index, ...
                  'VariableSizeOutput',            obj.VariableSizeOutput, ...
                  'SamplesPerFrame',               obj.SamplesPerFrame, ...
                  'ResetInputPort',                obj.ResetInputPort,...
                  'OutputDataType',                obj.OutputDataType);              
          else % input port
              obj.cGenerator = comm.internal.GoldSequenceXor(...
                  'FirstPolynomial',               obj.FirstPolynomial, ...
                  'FirstInitialConditions',        obj.FirstInitialConditions, ...
                  'SecondPolynomial',              obj.SecondPolynomial, ...
                  'SecondInitialConditionsSource', obj.SecondInitialConditionsSource, ...
                  'Shift',                         obj.Shift, ...
                  'Index',                         obj.Index, ...
                  'VariableSizeOutput',            obj.VariableSizeOutput, ...
                  'SamplesPerFrame',               obj.SamplesPerFrame, ...
                  'OutputDataType',                obj.OutputDataType);              
          end
      end
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
    reset(obj.cGenerator)
  end
  
  function releaseImpl(obj)
    release(obj.cGenerator)
  end
  
  function flag = isInactivePropertyImpl(obj, prop)
    flag = false;
    switch prop
      case 'MaximumOutputSize'
        if ~obj.VariableSizeOutput
          flag = true;
        end
      case 'SamplesPerFrame'
        if obj.VariableSizeOutput
          flag = true;
        end
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
      s.cGenerator = matlab.System.saveObject(obj.cGenerator);
    end
  end
  
  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      obj.cGenerator = matlab.System.loadObject(s.cGenerator);
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end
end % methods, protected API

methods (Access = private)
  function binaryPoly = checkPNSequenceInputs(~, poly, shift)
    [binaryPoly, ~, eStr] = commblkpnseq2(...
      poly,...
      1,... % always set mask via property (maskSourceIndx = 1)
      shift);
    if eStr.ecode
        coder.internal.errorIf(true,'comm:commblkpnseq2:InvalidGenPoly');
    end
end
end
end
