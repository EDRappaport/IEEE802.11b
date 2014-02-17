classdef BarkerCode < matlab.System
%BarkerCode Generate Barker code
%   H = comm.BarkerCode creates a Barker code generator System object, H,
%   that generates a Barker code of a specified length.
%
%   H = comm.BarkerCode(Name,Value) creates a Barker code generator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H) outputs a frame of the Barker code in column vector Y. You
%   specify the frame length with the SamplesPerFrame property. The output
%   code is in a bi-polar format with 0 and 1 mapped to 1 and -1,
%   respectively.
%
%   BarkerCode methods:
%
%   step     - Generate Barker code samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Barker code generator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of Barker code generator object
%
%   BarkerCode properties:
%
%   Length          - Length of generated code
%   SamplesPerFrame - Number of output samples per frame
%   OutputDataType  - Data type of output
%
%   % Example:
%   %   Generate 10 samples of a Barker code sequence of length 7
%
%   hBCode = comm.BarkerCode('SamplesPerFrame', 10);
%   seq = step(hBCode)
%
%   See also comm.HadamardCode, comm.OVSFCode.

%   Copyright 2009-2012 The MathWorks, Inc.

%#codegen
%#ok<*EMCLS>

properties (Nontunable)  
  %Length Length of generated code
  %   Specify the length of the Barker code as a numeric, integer scalar in
  %   the set {1, 2, 3, 4, 5, 7, 11, 13}. The default is 7. The codes that
  %   the object generates for a specified length are listed below:
  %
  %       Length      BarkerCode
  %       1           [-1]
  %       2           [-1 1]
  %       3           [-1 -1 1]
  %       4           [-1 -1 1 -1]
  %       5           [-1 -1 -1 1 -1]
  %       7           [-1 -1 -1 1 1 -1 1]
  %       11          [-1 -1 -1 1 1 1 -1 1 1 -1 1]
  %       13          [-1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1]
  Length = 7;
  %SamplesPerFrame Number of output samples per frame
  %   Specify the number of Barker code samples that the step method outputs
  %   as a numeric, integer scalar. If you set this property to a value of
  %   M, then the step method outputs M samples of a Barker code sequence of
  %   length N. N represents the length of the code that you specify in the
  %   Length property. The default is 1.
  SamplesPerFrame = 1;
  %OutputDataType Data type of output
  %   Specify the output data type as one of 'double' | 'int8'. The default
  %   is 'double'.
  OutputDataType = 'double';
end

properties(Access = private, Nontunable)
  pData       % store the sequence
end

properties(Access = private)
  pDataIndex  % point to the index of last output data
end

properties (Constant, Hidden)
  OutputDataTypeSet = comm.CommonSets.getSet('DoubleInt8');
end

methods
  %Constructor
  function obj = BarkerCode(varargin)
    setProperties(obj, nargin, varargin{:});
  end
  
  function set.SamplesPerFrame(obj, value)
    validateattributes( value, { 'numeric' }, { 'finite', 'nonempty', 'positive', 'real', 'scalar', 'integer' }, '', 'SamplesPerFrame'); %#ok<EMCA>
    obj.SamplesPerFrame = value;
  end
  
  function set.Length(obj, value)
      validateattributes( value, { 'numeric' }, { 'finite', 'nonempty', 'positive', 'real', 'scalar', 'integer' }, '', 'Length');     %#ok<EMCA>
      coder.internal.errorIf(~ismember(value,[1 2 3 4 5 7 11 13]),'comm:sysObj:BarkerCode_invalidCodeLength');
      obj.Length = value;
  end  
end

methods(Access = protected)
  
  function outSeq = stepImpl(obj)
    % retrieve the data stored in the private property pData and output the
    % data in circular buffer fashion.
    range = mod(obj.pDataIndex + (0:(obj.SamplesPerFrame - 1)), ...
      obj.Length) + 1;  
    outSeq = obj.pData(range);
    obj.pDataIndex = range(end);
  end
    
  function num = getNumInputsImpl(~)
    num = 0;
  end
  
  function setupImpl(obj)
    switch(obj.Length)
      case 1
        seq = -1;
      case 2
        seq = [-1 1];
      case 3
        seq = [-1 -1 1];
      case 4
        seq = [-1 -1 1 -1]; 
      case 5
        seq = [-1 -1 -1 1 -1];
      case 7
        seq = [-1 -1 -1 1 1 -1 1];
      case 11
        seq = [-1 -1 -1 1 1 1 -1 1 1 -1 1];
      case 13
        seq = [-1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1];
    end
    obj.pData = cast(seq, obj.OutputDataType).';
  end 
  
  function resetImpl(obj)
    obj.pDataIndex = 0; 
  end
  
  function flag = isOutputComplexityLockedImpl(~,~)
    flag = true;
  end
  
  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      s.pData = obj.pData;
      s.pDataIndex = obj.pDataIndex;
    end
  end
  
  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      obj.pData = s.pData;
      obj.pDataIndex = s.pDataIndex;
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end
end

end
