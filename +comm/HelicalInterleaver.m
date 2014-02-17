classdef HelicalInterleaver < matlab.System
%HelicalInterleaver Permute input symbols using a helical array
%   H = comm.HelicalInterleaver creates a helical interleaver System object,
%   H. The object permutes the input symbols in the input signal by placing
%   them in an array in a helical fashion.
%
%   H = comm.HelicalInterleaver(Name,Value) creates a helical interleaver
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) permutes input sequence, X, and returns interleaved
%   sequence, Y. The input X must be a column vector. The data type must be
%   numeric, logical, or fixed-point (fi objects). Y has the same data type
%   as X.
%
%   The helical interleaver object places the elements of X in an array in a
%   helical fashion. If you set the NumColumns property of the object to C,
%   then the array has C columns and unlimited rows. If you set the
%   GroupSize property to N, then the object accepts an input of length C*N
%   and partitions the input into consecutive groups of N symbols. The
%   object places the kth group in the array along column k mod C. This
%   placement is of type helical because of the reduction modulo C and
%   because the first symbol in the kth group is in the row 1+(k-1)*s, where
%   s is the value for the StepSize property. Positions in the array that do
%   not contain input symbols have default contents specified by the
%   InitialConditions property. The object outputs C*N symbols from the
%   array by reading the next N rows sequentially.
%
%   HelicalInterleaver methods:
%
%   step     - Interleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create helical interleaver object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the helical interleaver object
%
%   HelicalInterleaver properties:
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
%   See also comm.HelicalDeinterleaver, comm.MultiplexedInterleaver.

%   Copyright 2009-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.11 $ $Date: 2012/06/13 08:48:45 $

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
  cMatrixInterleaver      % Matrix interleaver System object
  cMultiplexedInterleaver % Multiplexed Interleaver System object
end

methods
  function obj = HelicalInterleaver(varargin)
    setProperties(obj, nargin, varargin{:});
  end

  function set.NumColumns(obj, value)
    validateattributes( value, { 'numeric' }, { 'finite', 'nonempty', 'positive', 'integer', 'scalar' }, '', 'NumColumns'); %#ok<EMCA>
    obj.NumColumns = value;
  end

  function set.GroupSize(obj, value)
    validateattributes( value, { 'numeric' }, { 'finite', 'nonempty', 'positive', 'integer', 'scalar' }, '', 'GroupSize'); %#ok<EMCA>
    obj.GroupSize = value;
  end

  function set.StepSize(obj, value)
    validateattributes( value, { 'numeric' }, ...
      { 'finite', 'nonempty', 'positive', 'integer', 'scalar' }, ...
      '', 'StepSize'); %#ok<EMCA>
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
    y = step(obj.cMatrixInterleaver, in);
    y = step(obj.cMultiplexedInterleaver, y);
  end

  function validateInputsImpl(obj, in)
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
    % setup the Matrix interleaver and General Multiplexed
    % interleaver sub system.
    obj.cMatrixInterleaver = comm.MatrixInterleaver( ...
      'NumColumns', obj.GroupSize, ...
      'NumRows', obj.NumColumns);
    obj.cMultiplexedInterleaver = comm.MultiplexedInterleaver( ...
      'Delay', (0:obj.StepSize:(obj.NumColumns-1)*obj.StepSize)', ...
      'InitialConditions', obj.InitialConditions);
  end
  
  function resetImpl(obj)
    reset(obj.cMatrixInterleaver)
    reset(obj.cMultiplexedInterleaver)
  end
  
  function releaseImpl(obj)
    release(obj.cMatrixInterleaver)
    release(obj.cMultiplexedInterleaver)
  end  
  
  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      s.cMatrixInterleaver = ...
        matlab.System.saveObject(obj.cMatrixInterleaver);
      s.cMultiplexedInterleaver = ...
        matlab.System.saveObject(obj.cMultiplexedInterleaver);
    end
  end
  
  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      obj.cMatrixInterleaver = ...
        matlab.System.loadObject(s.cMatrixInterleaver);
      obj.cMultiplexedInterleaver = ...
        matlab.System.loadObject(s.cMultiplexedInterleaver);
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end
end
end
