classdef HelicalDeinterleaver < matlab.System
%HelicalDeinterleaver Restore ordering of symbols using a helical array
%   H = comm.HelicalDeinterleaver creates a helical deinterleaver System
%   object, H. The object restores the original ordering of a sequence that
%   was interleaved using the helical interleaver System object.
%
%   H = comm.HelicalDeinterleaver(Name,Value) creates a Helical
%   deinterleaver object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) restores the original ordering of the sequence, X,
%   that was interleaved using a helical interleaver and returns Y. The
%   input X must be a column vector. The data type must be numeric,
%   logical, or fixed-point (fi objects). Y has the same data type as X. 
%
%   The helical deinterleaver object uses an array for its computations. If
%   you set the NumColumns property of the object to C, then the array has C
%   columns and unlimited rows. If you set the GroupSize property to N, then
%   the object accepts an input of length C*N and inserts it into the next N
%   rows of the array. The object also places the value of the
%   InitialConditions property into certain positions in the top few rows of
%   the array (not only to accommodate the helical pattern but also to
%   preserve the vector indices of symbols that pass through the
%   HelicalInterleaver and HelicalDeinterleaver objects in turn). The output
%   consists of consecutive groups of N symbols. The object selects the kth
%   output group in the array from column k mod C. This selection is of type
%   helical because of the reduction modulo C and because the first symbol
%   in the kth group is in row 1+(k-1)*s, where s is the value for the
%   StepSize property.
%
%   HelicalDeinterleaver methods:
%
%   step     - Deinterleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create helical deinterleaver object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the helical deinterleaver object
%
%   HelicalDeinterleaver properties:
%
%   NumColumns        - Number of columns in helical array
%   GroupSize         - Size of each group of input symbols
%   StepSize          - Helical array step size
%   InitialConditions - Initial conditions of helical array
%
%   % Example:
%   %   Interleave and deinterleave random data
%
%   hInt = comm.HelicalInterleaver('GroupSize', 2, ...
%                   'NumColumns', 3, ...
%                   'InitialConditions', -1);
%   hDeInt = comm.HelicalDeinterleaver('GroupSize', 2, ...
%                   'NumColumns', 3, ...
%                   'InitialConditions', -1);
%   data = randi(7, 6, 1);
%   intData = step(hInt, data);
%   deIntData = step(hDeInt, intData);
%   % compare the original sequence, interleaved sequence, and restored
%   % sequence
%   [data, intData, deIntData]
%
%   See also comm.HelicalInterleaver, comm.MultiplexedDeinterleaver.

%   Copyright 2009-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.11 $  $Date: 2012/06/13 08:48:44 $

%#codegen
%#ok<*EMCLS>

properties (Nontunable)
  %NumColumns Number of columns in helical array
  %   Specify the number of columns in the helical array as a positive
  %   integer scalar. The default is 6.
  NumColumns = 6;
  %GroupSize Size of each group of input symbols
  %   Specify the size of each group of input symbols as a positive integer
  %   scalar. The default is 4.
  GroupSize = 4;
  %StepSize Helical array step size
  %   Specify number of rows of separation between consecutive input groups
  %   in their respective columns of the helical array as a positive integer
  %   scalar. The default is 1.
  StepSize = 1;
  %InitialConditions Initial conditions of helical array
  %   Specify the value that is initially stored in the helical array as a
  %   numeric scalar. The default is 0.
  InitialConditions = 0;
end

properties(Access = private, Nontunable)
  cMatrixDeinterleaver          % Matrix deinterleaver System object
  cMultiplexedDeinterleaver     % MultiplexedDeinterleaver System object
  cDelay                        % Delay System object
end

methods
  function obj = HelicalDeinterleaver(varargin)
    setProperties(obj, nargin, varargin{:});
  end
  
  function set.NumColumns(obj, value)
    validateattributes( value, { 'numeric' }, ...
      { 'finite', 'nonempty', 'positive', 'integer', 'scalar' }, '', ...
      'NumColumns'); %#ok<EMCA>
    obj.NumColumns = value;
  end
  
  function set.GroupSize(obj, value)
    validateattributes( value, { 'numeric' }, ...
      { 'finite', 'nonempty', 'positive', 'integer', 'scalar' }, '', ...
      'GroupSize'); %#ok<EMCA>
    obj.GroupSize = value;
  end
  
  function set.StepSize(obj, value)
    validateattributes( value, { 'numeric' }, ...
      { 'finite', 'nonempty', 'positive', 'integer', 'scalar' }, '', ...
      'StepSize'); %#ok<EMCA>
    obj.StepSize = value;
  end
  
  function set.InitialConditions(obj, value)
    validateattributes( value, { 'numeric' }, ...
      { 'finite', 'nonempty', 'scalar' }, '', 'InitialConditions'); %#ok<EMCA>
    obj.InitialConditions = value;
  end
end

methods(Access = protected)
  function y = stepImpl(obj, in)
    y = step(obj.cMultiplexedDeinterleaver, in);
    y = step(obj.cDelay, y);
    y = step(obj.cMatrixDeinterleaver, y);
  end
  
  function validateInputsImpl(obj,in)
    coder.extrinsic('mat2str')
    % Check that the input is a column vector of length C*N            
    sz = size(in);
    esz = [obj.GroupSize*obj.NumColumns 1];
    coder.internal.assert(isequal(sz, esz), ...
      'MATLAB:system:invalidInputDimensions', ...
      'X', coder.internal.const(mat2str(esz)), ...
      coder.internal.const(mat2str(sz)));
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
    % setup the Matrix deinterleaver and General Multiplexed
    % deinterleaver sub-system.
    obj.cMatrixDeinterleaver = comm.MatrixDeinterleaver( ...
      'NumColumns', obj.GroupSize, ...
      'NumRows', obj.NumColumns);
    obj.cMultiplexedDeinterleaver = comm.MultiplexedDeinterleaver( ...
      'Delay', (0:obj.StepSize:(obj.NumColumns-1)*obj.StepSize)', ...
      'InitialConditions', obj.InitialConditions);
    d = mod(obj.NumColumns*obj.GroupSize - ...
      obj.StepSize*obj.NumColumns*(obj.NumColumns-1), ...
      obj.NumColumns*obj.GroupSize);
    obj.cDelay = dsp.Delay('Length', d);
  end
  
  function resetImpl(obj)
    reset(obj.cMatrixDeinterleaver)
    reset(obj.cDelay)
    reset(obj.cMultiplexedDeinterleaver)
  end
  
  function releaseImpl(obj)
    release(obj.cMatrixDeinterleaver)
    release(obj.cDelay)
    release(obj.cMultiplexedDeinterleaver)
  end
  
  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      s.cMatrixDeinterleaver = ...
        matlab.System.saveObject(obj.cMatrixDeinterleaver);
      s.cMultiplexedDeinterleaver = ...
        matlab.System.saveObject(obj.cMultiplexedDeinterleaver);
      s.cDelay = matlab.System.saveObject(obj.cDelay);
    end
  end
  
  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      obj.cMatrixDeinterleaver = ...
        matlab.System.loadObject(s.cMatrixDeinterleaver);
      obj.cMultiplexedDeinterleaver = ...
        matlab.System.loadObject(s.cMultiplexedDeinterleaver);
      obj.cDelay = matlab.System.loadObject(s.cDelay);
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end
end
end
