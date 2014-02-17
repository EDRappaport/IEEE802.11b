classdef TurboEncoder < matlab.System & matlab.system.mixin.Propagates ...
    & matlab.system.mixin.CustomIcon
%TurboEncoder Encode binary data using a turbo encoder.
%   H = comm.TurboEncoder creates a System object, H, that encodes binary
%   data using a turbo encoder.
%
%   H = comm.TurboEncoder(Name, Value) creates a turbo encoder object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1, Value1, ... , NameN, ValueN).
%
%   H = comm.TurboEncoder(TRELLIS, INTERLVRINDICES) creates a
%   turbo encoder object, H, with the TrellisStructure property set to
%   TRELLIS, and the InterleaverIndices property set to INTERLVRINDICES.
%
%   Step method syntax:
%
%   Y = step(H, X) encodes the binary data, X, using the parallel
%   concatenated convolutional encoding scheme that you specify by the
%   TrellisStructure and InterleaverIndices properties. It returns the
%   encoded data, Y. Both X and Y are column vectors of data type numeric,
%   logical, or unsigned fixed point with word length 1 (fi object).
%   When the constituent convolutional encoder represents a rate 1/N code,
%   the step method sets the length of the output vector, Y, to L*(2*N-1)+
%   2*numTails, where L is the input vector length and numTails is given by
%   log2(TrellisStructure.numStates)*N. The tail bits, due to the
%   termination, are appended at the end after the input bits are encoded.
%
%   Y = step(H, X, INTERLVRINDICES) uses the INTERLVRINDICES specified as
%   an input. INTERLVRINDICES is a column vector containing integer values
%   from 1 to L with no repeated values. The length of the data input X and
%   INTERLVRINDICES input must be the same and equal to L.
%
%   TurboEncoder methods:
%
%   step     - Perform turbo encoding (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create turbo encoder object with same property values
%   isLocked - Locked status (logical)
%
%   TurboEncoder properties:
%
%   TrellisStructure         - Trellis structure of constituent 
%                              convolutional code
%   InterleaverIndicesSource - Source of interleaving indices
%   InterleaverIndices       - Interleaving indices
%
%   % Example:
%   %   Transmit turbo-encoded blocks of data over a BPSK-modulated AWGN
%   %   channel, decode using an iterative turbo decoder and display errors
% 
%   noiseVar = 4; frmLen = 256;
%   s = RandStream('mt19937ar', 'Seed', 11);
%   intrlvrIndices = randperm(s, frmLen);
% 
%   hTEnc  = comm.TurboEncoder('TrellisStructure', poly2trellis(4, ...
%            [13 15 17], 13), 'InterleaverIndices', intrlvrIndices);
%   hMod   = comm.BPSKModulator;
%   hChan  = comm.AWGNChannel('NoiseMethod', 'Variance', 'Variance', noiseVar);
%   hTDec  = comm.TurboDecoder('TrellisStructure', poly2trellis(4, ...
%            [13 15 17], 13), 'InterleaverIndices', intrlvrIndices, ...
%            'NumIterations', 4);
%   hError = comm.ErrorRate;
% 
%   for frmIdx = 1:8
%       data = randi(s, [0 1], frmLen, 1);
%       encodedData = step(hTEnc, data);
%       modSignal = step(hMod, encodedData);
%       receivedSignal = step(hChan, modSignal);
% 
%       % Convert received signal to log-likelihood ratios for decoding
%       receivedBits  = step(hTDec, (-2/(noiseVar/2))*real(receivedSignal));
%     
%       errorStats = step(hError, data, receivedBits);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\nTotal bits = %d\n', ...
%   errorStats(1), errorStats(2), errorStats(3))     
%
%   See also comm.TurboDecoder, comm.ConvolutionalEncoder.

% Notice: Supply of this software does not convey a license nor imply any
% right to use any Turbo codes patents owned by France Telecom,
% Telediffusion de France and/or Groupe des Ecoles des Telecommunications
% except in connection with use of the software for the purposes of design,
% simulation and analysis. Code generated from Turbo codes technology in
% this software is not intended and/or suitable for implementation or
% incorporation in any commercial products.
% 
% Please contact France Telecom for information about Turbo Codes Licensing
% program at the following address: France Telecom R&D - PIV/TurboCodes
% 38-40, rue du General Leclerc 92794 Issy-les-Moulineaux Cedex 9, France.

%   Copyright 2011-2013 The MathWorks, Inc.

%#codegen
%#ok<*EMCA>

properties (Nontunable)
  %TrellisStructure Trellis structure of constituent convolutional code
  %   Specify the trellis as a MATLAB structure that contains the trellis
  %   description of the constituent convolutional code. Use the istrellis
  %   function to check if a structure is a valid trellis structure. The
  %   default is the result of poly2trellis(4, [13 15], 13).
  %
  %   See also istrellis, poly2trellis.
  TrellisStructure = poly2trellis(4, [13 15], 13);
  %InterleaverIndicesSource Source of interleaver indices
  %   Specify the source of the interleaver indices as one of 'Property' |
  %   'Input port'. The default is 'Property'. When you set this property
  %   to 'Input port' the object uses the interleaver indices specified as
  %   an input to the step method. When you set this property to
  %   'Property', the object uses the interleaver indices that you specify
  %   in the InterleaverIndices property.
  InterleaverIndicesSource = 'Property';
  %InterleaverIndices Interleaver indices
  %   Specify the mapping used to permute the input bits as a column vector
  %   of integers. The default is (64:-1:1).'. This mapping is a vector
  %   with the number of elements equal to length, L, of the input to the
  %   step method. Each element must be an integer between 1 and L, with no
  %   repeated values.
  InterleaverIndices = (64:-1:1).';
end

properties (Constant, Hidden)
    InterleaverIndicesSourceSet = comm.CommonSets.getSet('SpecifyInputs');
end

properties(Access = private, Nontunable)
    % Constituent components
    cConvEnc1;      % encoder1
    cConvEnc2;      % encoder2
    % Commonly used attributes - set for default TrellisStructure
    pK = 1;             % number of uncoded bits
    pN = 2;             % number of coded bits
    pMLen = 3;          % memory length of a constituent encoder
    pNumTails = 6;      % number of tail bits per constituent encoder
end

methods
    % CONSTRUCTOR
    function obj = TurboEncoder(varargin)
        setProperties(obj, nargin, varargin{:}, 'TrellisStructure', ...
                      'InterleaverIndices');
    end
    
    function set.InterleaverIndices(obj, value)
            validateattributes(value, {'numeric'}, ...
            {'real', 'finite', 'positive', 'integer', 'vector'}, ...
            '', 'InterleaverIndices'); %#ok<EMCA>

        obj.InterleaverIndices = value;
    end
end

methods(Access = protected)   % System object APIs

    %% Number of Inputs
    function num = getNumInputsImpl(obj)
        num = 1 + strcmp(obj.InterleaverIndicesSource, 'Input port');
    end

    %% Size propagators
    function flag = isInputSizeLockedImpl(obj,~)
        if strcmp(obj.InterleaverIndicesSource, 'Input port')
            flag = false;   % vars only via input port
        else
            flag = true;
        end
    end
        
    function varargout = isOutputFixedSizeImpl(obj)
        if strcmp(obj.InterleaverIndicesSource, 'Input port')
            varargout = {false};   
        else
            varargout = {true};    
        end
    end
    
    function varargout = getOutputSizeImpl(obj)
        inSize = inputSize(obj, 1);
        pn = log2(obj.TrellisStructure.numOutputSymbols);
        pmlen = log2(obj.TrellisStructure.numStates);
        pnumtails = pmlen*pn;

        outLen = inSize(1) * (2*pn - 1) + 2*pnumtails;
        varargout = {[outLen, 1]}; 
    end
    
    %% Type propagators
    function varargout = getOutputDataTypeImpl(obj)
        varargout = {inputDataType(obj, 1)};  
    end
    
    %% Complexity propagators
    function flag = isInputComplexityLockedImpl(~,~)
        flag = true;
    end
    
    function flag = isOutputComplexityLockedImpl(~,~)
        flag = true;
    end
    
    function varargout = isOutputComplexImpl(~)
        varargout = {false}; 
    end
    
    %% Setup
    function setupImpl(obj, varargin)
        [isOk, status] = istrellis(obj.TrellisStructure);
        coder.internal.errorIf(~isOk,'comm:TurboEncoder:InvalidTrellis', status);
        obj.cConvEnc1 = comm.ConvolutionalEncoder('TrellisStructure',...
            obj.TrellisStructure, 'TerminationMethod', 'Terminated');
        obj.cConvEnc2 = comm.ConvolutionalEncoder('TrellisStructure',...
            obj.TrellisStructure, 'TerminationMethod', 'Terminated');

        obj.pK = log2(obj.TrellisStructure.numInputSymbols);
        assert(obj.pK==1, 'comm:system:TurboEncoder:invalidTrellis',...
              'Only rate 1/n trellises are supported.');

        obj.pN = log2(obj.TrellisStructure.numOutputSymbols);
        obj.pMLen = log2(obj.TrellisStructure.numStates);
        obj.pNumTails = obj.pMLen*(obj.pN);
    end

    %% Step
    function y = stepImpl(obj, x, varargin)

        if strcmp(obj.InterleaverIndicesSource, 'Input port')
            interlvrIndices = varargin{1};
            blkLen = length(interlvrIndices);
        else
            interlvrIndices = get(obj, 'InterleaverIndices');
            blkLen = length(interlvrIndices);
        end
        assert(isequal((1:blkLen).', sort(interlvrIndices(:))),...
            'comm:system:TurboEncoder:invalidIndices',...
            ['The InterleaverIndices must be a positive ',...
            'integer vector with unique elements.']);
        assert(length(x) == blkLen,...
            'comm:system:TurboEncoder:InputLengthMismatch', ...
            ['The length of the input must be the same as the ',...
            'length of the interleaver indices specified.']);

        if (blkLen > 0)            
            y1 = step(obj.cConvEnc1, x);
            y2 = step(obj.cConvEnc2, x(interlvrIndices));
            
            % Bit reorder
            dIdx = obj.pN * blkLen;
            y1D = reshape(y1((1:dIdx).'), obj.pN, blkLen);
            y2D = reshape(y2((1:dIdx).'), obj.pN, blkLen);
            %   Remove 2nd systematic
            yDTemp = [y1D; y2D(2:obj.pN,:)];
            
            %   Get tails
            y1T = y1(dIdx + (1:obj.pNumTails).');
            y2T = y2(dIdx + (1:obj.pNumTails).');
            
            %   Append tails to end
            y = [yDTemp(:); y1T(:); y2T(:)];
        else
            % allow empty input
            y = [];
        end
    end
    
    %%
    function releaseImpl(obj)
        release(obj.cConvEnc1);
        release(obj.cConvEnc2);
    end
    
    function flag = isInactivePropertyImpl(obj, prop)
        flag = false;
        switch prop
            case 'InterleaverIndices'
                if strcmp(obj.InterleaverIndicesSource, 'Input port')
                    flag = true;
                end
            case 'NumScalingBits'
                if ~strcmp(obj.Algorithm, 'Max*')
                    flag = true;
                end
        end
    end
  
    function s = saveObjectImpl(obj)
        s = saveObjectImpl@matlab.System(obj);
        if isLocked(obj)
            s.pK        = obj.pK;
            s.pN        = obj.pN;
            s.pMLen     = obj.pMLen;
            s.pNumTails = obj.pNumTails;
            s.cConvEnc1  = matlab.System.saveObject(obj.cConvEnc1);
            s.cConvEnc2  = matlab.System.saveObject(obj.cConvEnc2);
        end
    end
  
    function loadObjectImpl(obj, s, wasLocked)
        if wasLocked
            obj.pK        = s.pK;
            obj.pN        = s.pN;
            obj.pMLen     = s.pMLen;
            obj.pNumTails = s.pNumTails;
            obj.cConvEnc1  = matlab.System.loadObject(s.cConvEnc1);
            obj.cConvEnc2  = matlab.System.loadObject(s.cConvEnc2);
        end
        % Call the base class method
        loadObjectImpl@matlab.System(obj, s);
    end

    function icon = getIconImpl(~)        
        icon = sprintf('Turbo\nEncoder');
    end
  
    function varargout = getInputNamesImpl(obj)
        varargout = cell(1, getNumInputs(obj));        
        if strcmp(obj.InterleaverIndicesSource, 'Input port')
            varargout{1} = 'In';
            varargout{2} = 'IntrInd';
        else
            varargout{1} = '';
        end
    end
end 

methods(Static, Access=protected)
    
    function header = getHeaderImpl
        header = matlab.system.display.Header('comm.TurboEncoder', ...
            'Title', 'Turbo Encoder', 'Text', ...
            ['Encode binary data using a parallel concatenated coding ',...
             'scheme' sprintf('\n') 'that employs the convolutional ',...
             'encoder as the constituent encoder.' sprintf('\n\n') ,...
             'Both the constituent encoders use the same trellis ' ,...
             'structure.' sprintf('\n\n') ,...
             'Use the poly2trellis function to create a trellis using', ...
             ' the constraint' sprintf('\n') 'length, code generator ',...
             '(octal) and feedback connection (octal).']);
    end
    
    % Specify aliases to existing block parameters
    function group = getPropertyGroupsImpl
        
        p1 = matlab.system.display.internal.Property('TrellisStructure', ...
            'Description', 'Trellis structure', ...
            'Alias', 'trellis');        
        p2 = matlab.system.display.internal.Property('InterleaverIndices', ...
            'Description', 'Interleaver indices', ...
            'Alias', 'intrIndices');
        
        group = matlab.system.display.Section(...
            'Title', 'Parameters', ...
            'PropertyList', {p1, 'InterleaverIndicesSource', p2});
    end

end

end
