classdef TurboDecoder < matlab.System & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
%TurboDecoder Decode input using a turbo decoder.
%   H = comm.TurboDecoder creates a turbo decoder System object, H. This
%   object uses the a-posteriori probability (APP) constituent decoder to
%   iteratively decode the parallel-concatenated convolutionally encoded
%   input data.
%
%   H = comm.TurboDecoder(Name, Value) creates a turbo decoder object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1, Value1, ... , NameN, ValueN).
%
%   H = comm.TurboDecoder(TRELLIS, INTERLVRINDICES, NUMITER) creates a
%   turbo decoder object, H, with the TrellisStructure property set to
%   TRELLIS, the InterleaverIndices property set to INTERLVRINDICES and 
%   the NumIterations property set to NUMITER.
%
%   Step method syntax:
%
%   Y = step(H, X) decodes the input data, X, using the parallel
%   concatenated convolutional coding scheme that you specify using the
%   TrellisStructure and InterleaverIndices properties. It returns the
%   binary decoded data, Y. Both X and Y are column vectors of double or
%   single precision data type. When the constituent convolutional code
%   represents a rate 1/N code, the step method sets the length of the
%   output vector, Y, to (M-2*numTails)/(2*N-1), where M is the input
%   vector length and numTails is given by
%   log2(TrellisStructure.numStates)*N. The output length, L, is the same
%   as the length of the interleaver indices.
%
%   Y = step(H, X, INTERLVRINDICES) uses the INTERLVRINDICES specified as
%   an input. INTERLVRINDICES is a column vector containing integer values
%   from 1 to L with no repeated values. The lengths of the INTERLVRINDICES
%   input and the Y output are the same.
%
%   TurboDecoder methods:
%
%   step     - Perform turbo decoding (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create turbo decoder object with same property values
%   isLocked - Locked status (logical)
%
%   TurboDecoder properties:
%
%   TrellisStructure         - Trellis structure of constituent 
%                              convolutional code
%   InterleaverIndicesSource - Source of interleaving indices
%   InterleaverIndices       - Interleaving indices
%   Algorithm                - Decoding algorithm
%   NumScalingBits           - Number of scaling bits
%   NumIterations            - Number of decoding iterations
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
%   See also comm.TurboEncoder, comm.APPDecoder.

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
  %   Specify the mapping used to permute the input bits at the encoder as
  %   a column vector of integers. The default is (64:-1:1).'. This mapping
  %   is a vector with the number of elements equal to length, L,
  %   of the output of the step method. Each element must be an integer
  %   between 1 and L, with no repeated values.
  InterleaverIndices = (64:-1:1).';
  %Algorithm Decoding algorithm
  %   Specify the decoding algorithm that the object uses for decoding as
  %   one of 'True APP' | 'Max*' | 'Max'. The default is 'TrueAPP'. When
  %   you set this property to 'True APP', the object implements true a
  %   posteriori probability decoding. When you set this property to any
  %   other value, the object uses approximations to increase the speed of
  %   the computations.
  Algorithm = 'True APP';
  %NumScalingBits Number of scaling bits
  %   Specify the number of bits the constituent decoders use to scale the
  %   input data to avoid losing precision during computations. The
  %   constituent decoders multiply the input by 2^NumScalingBits and
  %   divide the pre-output by the same factor. NumScalingBits must be a
  %   scalar integer between 0 and 8. This property applies when you set
  %   the Algorithm property to 'Max*'. The default is 3.
  NumScalingBits = 3;
  %NumIterations Number of decoding iterations
  %   Specify the number of decoding iterations used for each call to the
  %   step method. The default is 6. The object will iterate and provide
  %   updates to the log-likelihood ratios (LLR) of the uncoded output
  %   bits. The output of the step method is the hard-decision output of
  %   the final LLR update.
  NumIterations = 6;
end

properties (Constant, Hidden)
    InterleaverIndicesSourceSet = comm.CommonSets.getSet('SpecifyInputs');
    AlgorithmSet = comm.CommonSets.getSet('Algorithm');
end

properties(Access = private, Nontunable)
    % Constituent components
    cAPPDec1;       % decoder1
    cAPPDec2;       % decoder2
    % Commonly used attributes - set for default TrellisStructure
    pK = 1;             % number of uncoded bits
    pN = 2;             % number of coded bits
    pMLen = 3;          % memory length of a constituent encoder
    pNumTails = 6;      % number of tail bits per constituent encoder
end

methods
    % CONSTRUCTOR
    function obj = TurboDecoder(varargin)
        setProperties(obj, nargin, varargin{:}, 'TrellisStructure', ...
                      'InterleaverIndices', 'NumIterations');
    end
    
    function set.InterleaverIndices(obj, value)
        validateattributes(value,...
            {'numeric'}, {'real', 'finite', 'positive', 'integer', ...
            'vector'}, '','InterleaverIndices');     %#ok<EMCA>
        obj.InterleaverIndices = value;
    end
    
    function set.NumScalingBits(obj, value)
        validateattributes(value, ...
            {'numeric'}, {'real', 'finite', 'nonnegative', 'integer', ...
            'scalar', '>=', 0, '<=', 8}, '', 'NumScalingBits');     %#ok<EMCA>
        obj.NumScalingBits = value;
    end
    
    function set.NumIterations(obj, value)
        validateattributes(value,...
            {'numeric'}, {'real', 'finite', 'positive', 'integer', ...
            'scalar'}, '', 'NumIterations'); %#ok<EMCA>
        obj.NumIterations = value;
    end    
end
    
methods(Access = protected)   % System object APIs

    %% Validate inputs
    function validateInputsImpl(~, x, varargin)
        if ~isfloat(x)
            matlab.system.internal.error(...
                'MATLAB:system:invalidInputDataType','X','floating-point');
        else % is a float
            coder.internal.errorIf(isa(x, 'embedded.fi'),...
                                   'comm:TurboDecoder:invalidFiInput');
        end
    end
    
    %% Number of Inputs
    function num = getNumInputsImpl(obj)
        num = 1 + strcmp(obj.InterleaverIndicesSource, 'Input port');
    end
    
    %% Size propagators
    function flag = isInputSizeLockedImpl(obj,~)
        if strcmp(obj.InterleaverIndicesSource, 'Input port')
            flag = false; % vars only via input port
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
        if strcmp(obj.InterleaverIndicesSource, 'Input port')
            inSize = inputSize(obj, 2);
            varargout = {inSize};  
        else
            varargout = {[length(obj.InterleaverIndices) 1]}; 
        end
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
        coder.internal.errorIf(~isOk,'comm:TurboDecoder:InvalidTrellis', status );
        if strcmp(obj.Algorithm, 'Max*')
            obj.cAPPDec1 = comm.APPDecoder('TrellisStructure',...
                obj.TrellisStructure,...
                'TerminationMethod', 'Terminated',...
                'Algorithm', obj.Algorithm,...
                'NumScalingBits', obj.NumScalingBits,...
                'CodedBitLLROutputPort', false);
            obj.cAPPDec2 = comm.APPDecoder('TrellisStructure',...
                obj.TrellisStructure,...
                'TerminationMethod', 'Terminated',...
                'Algorithm', obj.Algorithm,...
                'NumScalingBits', obj.NumScalingBits,...
                'CodedBitLLROutputPort', false);
        else
            obj.cAPPDec1 = comm.APPDecoder('TrellisStructure',...
                obj.TrellisStructure,...
                'TerminationMethod', 'Terminated',...
                'Algorithm', obj.Algorithm, ...
                'CodedBitLLROutputPort', false);
            obj.cAPPDec2 = comm.APPDecoder('TrellisStructure',...
                obj.TrellisStructure,...
                'TerminationMethod', 'Terminated',...
                'Algorithm', obj.Algorithm, ...
                'CodedBitLLROutputPort', false);
        end

        obj.pK = log2(obj.TrellisStructure.numInputSymbols);
        assert(obj.pK==1, 'comm:system:TurboDecoder:invalidTrellis',...
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
            'comm:system:TurboDecoder:invalidIndices',...
            ['The InterleaverIndices must be a positive ',...
            'integer vector with unique elements.']);
        if blkLen > 0            
            assert((length(x)-2*obj.pNumTails)/(2*obj.pN-1)==blkLen,...
                'comm:system:TurboDecoder:inputLengthMismatch', ...
                ['Inconsistent input lengths. The length of the input ',...
                'must be related to the length of the interleaver indices ',...
                'as described in the step method help for the object.']);

            typex = class(x);
            % Bit order
            dIdx   = (2*obj.pN-1)*blkLen;
            yD     = reshape(x((1:dIdx).', 1), 2*obj.pN-1, blkLen);
            lc1D   = yD(1:obj.pN, :);
            y1T    = x(dIdx + (1:obj.pNumTails).', 1);
            Lc1_in = [lc1D(:); y1T];
            
            Lu1_in = zeros(blkLen+obj.pMLen, 1, typex);
            
            tmp = yD(1,:);
            lc2D1  = tmp(interlvrIndices(:));
            lc2D2  = yD(obj.pN+1:2*obj.pN-1, :);
            lc2D   = [lc2D1; lc2D2];
            y2T    = x(dIdx + obj.pNumTails + (1:obj.pNumTails).', 1);
            Lc2_in = [lc2D(:); y2T];
            
            % Turbo Decode
            out1 = zeros(blkLen, 1, typex);
            for iterIdx = 1:obj.NumIterations
                Lu1_out = step(obj.cAPPDec1, Lu1_in, Lc1_in);
                tmp = Lu1_out((1:blkLen).', 1);
                tmp2 = tmp(:);
                Lu2_out = step(obj.cAPPDec2, ...
                    [tmp2(interlvrIndices(:)); zeros(obj.pMLen,1, typex)], Lc2_in);
                
                out1(interlvrIndices(:), 1) = Lu2_out((1:blkLen).', 1);
                Lu1_in = [out1; zeros(obj.pMLen,1, typex)];
            end
            
            % Calculate llr and decoded bits - for the final iteration
            llr = out1 + tmp2;
            y = cast((llr>=0), typex);
        else
            % allow empty input
            y = [];
        end
    end

    %%
    function releaseImpl(obj)
        release(obj.cAPPDec1);
        release(obj.cAPPDec2);
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
            s.cAPPDec1  = matlab.System.saveObject(obj.cAPPDec1);
            s.cAPPDec2  = matlab.System.saveObject(obj.cAPPDec2);
        end
    end
  
    function loadObjectImpl(obj, s, wasLocked)
        if wasLocked
            obj.pK        = s.pK;
            obj.pN        = s.pN;
            obj.pMLen     = s.pMLen;
            obj.pNumTails = s.pNumTails;
            obj.cAPPDec1  = matlab.System.loadObject(s.cAPPDec1);
            obj.cAPPDec2  = matlab.System.loadObject(s.cAPPDec2);
        end
        % Call the base class method
        loadObjectImpl@matlab.System(obj, s);
    end
    
    function icon = getIconImpl(~)        
        icon = sprintf('Turbo\nDecoder');
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

methods(Static, Access = protected)
    function header = getHeaderImpl
        header = matlab.system.display.Header('comm.TurboDecoder', ...
            'Title', 'Turbo Decoder', 'Text', ...
            ['Decode input using a parallel concatenated decoding scheme' ,...
             ' that' sprintf('\n') 'employs the a posteriori probability',...
             ' (APP) decoder as the constituent' sprintf('\n') 'decoder.' ,...
             sprintf('\n\n') ,...
             'Both the constituent decoders use the same trellis ' ,...
             'structure and' sprintf('\n') 'algorithm.' ,...
             sprintf('\n\n') ,...
             'Use the poly2trellis function to create a trellis using' ,...
             ' the constraint' sprintf('\n') 'length, code generator ' ,...
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
        p3 = matlab.system.display.internal.Property('Algorithm', ...
            'Description', 'Decoding algorithm', ...
            'Alias', 'algorithm');
        p4 = matlab.system.display.internal.Property('NumScalingBits', ...
            'Description', 'Number of scaling bits', ...
            'Alias', 'numScaleBits');
        p5 = matlab.system.display.internal.Property('NumIterations', ...
            'Description', 'Number of decoding iterations', ...
            'Alias', 'numIter');        

        group = matlab.system.display.Section(...
            'Title', 'Parameters', ...
            'PropertyList', {p1, 'InterleaverIndicesSource', p2, p3, p4, p5});
    end
end

end
