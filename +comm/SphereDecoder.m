classdef SphereDecoder < matlab.System & matlab.system.mixin.Propagates & ...
    matlab.system.mixin.CustomIcon
%SphereDecoder Decode input using a sphere decoder.
%   H = comm.SphereDecoder creates a sphere decoder System object, H, for a
%   MIMO system with Nt transmit antennas and Nr receive antennas. This
%   object uses the sphere decoding algorithm to find the
%   maximum-likelihood solution for a set of symbols transmitted over the
%   MIMO channel.
%
%   H = comm.SphereDecoder(Name, Value) creates a sphere decoder object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as (Name1,
%   Value1, ... , NameN, ValueN).
%
%   H = comm.SphereDecoder(CONSTELLATION, BITTABLE) creates a sphere
%   decoder object, H, with the Constellation property set to
%   CONSTELLATION and the BitTable property set to BITTABLE.
%
%   Step method syntax:
%
%   Y = step(H, RXSYMBOLS, CHAN) decodes the received symbols, RXSYMBOLS,
%   using the sphere decoding algorithm. The algorithm can be employed to
%   decode Ns channel realizations in one call, where in each channel
%   realization, Nr symbols were received. 
%   The inputs are:
%       RXSYMBOLS: a [Ns Nr] complex double matrix containing the
%   received symbols.
%       CHAN: a [Ns Nt Nr] or [1 Nt Nr] complex double matrix
%   representing the fading channel coefficients of the flat-fading MIMO
%   channel. For the [Ns Nt Nr] case, each channel matrix is
%   applied to each Nr symbol set. For the block fading case, i.e., when
%   the size of CHAN is [1 Nt Nr], the same channel is applied to all of
%   the received symbols.
%   The output is:
%       Y: Depending on the setting of the DecisionType property, Y is a
%   double matrix containing the Log-Likelihood Ratios (LLRs) of the
%   decoded bits or the bits themselves. The size of the output is, for
%   both cases, [Ns*bitsPerSymbol Nt], where bitsPerSymbol
%   represents the number of bits per transmitted symbol, as determined by
%   the BitTable property.
%
%   SphereDecoder methods:
%
%   step     - Perform sphere decoding (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create sphere decoder object with same property values
%   isLocked - Locked status (logical)
%
%   SphereDecoder properties:
%
%   Constellation - The constellation points that modulate the transmitted
%                   bits.
%   BitTable      - The bits to which the symbols in the Constellation
%                   property are mapped.
%   InitialRadius - The initial search radius employed by the sphere
%                   decoding algorithm.
%   DecisionType  - Select the output to be LLRs or bits.
%
%   % Example:
%   % Transmit a set of bits modulated using 16-QAM constellation, as two
%   % parallel streams over a MIMO channel, and decode using a sphere
%   % decoder, with perfect channel knowledge.
%   
%   M             = 16;             % Modulation order
%   nBits         = 1e3*log2(M);    % Number of bits to transmit
%   noiseVariance = 1e-2;           % Noise variance 
%   symMap        = [11 10 14 15 9 8 12 13 1 0 4 5 3 2 6 7];  % Custom mapping
%   hMod = comm.RectangularQAMModulator('BitInput', true, ...
%       'ModulationOrder', M, 'NormalizationMethod', 'Average power',...
%       'SymbolMapping', 'Custom', 'CustomSymbolMapping', symMap);
%   BitTable = de2bi(symMap, log2(M), 'left-msb');
%   hMIMO = comm.MIMOChannel('RandomStream', 'mt19937ar with seed',...
%       'PathGainsOutputPort', true);
%   hAWGN = comm.AWGNChannel('NoiseMethod', 'Variance',...
%       'VarianceSource', 'Property', 'Variance', noiseVariance);
%   hSpDec = comm.SphereDecoder('Constellation', constellation(hMod),...
%       'BitTable', BitTable, 'DecisionType', 'Hard');
%   hBER = comm.ErrorRate;
%
%   data = randi([0 1], nBits, 1);      % Generate data
%   yMod = step(hMod, data);            % Modulate data
%   yTx  = reshape(yMod, [], 2);        % Split to two streams
%   [yFad, yPG] = step(hMIMO, yTx);     % Transmit over MIMO fading channel
%   yRec   = step(hAWGN, yFad);         % Add receiver noise
%   rxBits = step(hSpDec, yRec, squeeze(yPG));  % Decode received signal
%
%   ber = step(hBER, data, double(rxBits(:)));  % Compute errors
%   disp(ber(1));                               % Display BER
% 
%   See also comm.OSTBCCombiner, comm.MIMOChannel.

%   Copyright 2012-2013 The MathWorks, Inc.

%#codegen
%#ok<*EMCA>

properties (Nontunable)
    %Constellation Signal constellation
    %   Specify the constellation as a complex column vector containing the
    %   constellation points to which the transmitted bits are mapped. The
    %   length of the vector must be a power of two. The object assumes
    %   the same constellation is used for each transmit antenna. The
    %   default is a QPSK constellation with an average power of 1.
    Constellation = 1/sqrt(2) * [1+1i; 1-1i; -1+1i; -1-1i];
    %BitTable Bit mapping per constellation point
    %   Specify the bit mapping for the symbols specified in the
    %   Constellation property as a numerical matrix. The matrix size 
    %   must be [ConstellationLength bitsPerSymbol], where
    %   ConstellationLength represents the length of the Constellation
    %   property value and bitsPerSymbol represents the number of bits that
    %   each symbol encodes. The default is [0 0; 0 1; 1 0; 1 1], which
    %   matches the default Constellation property value.
    BitTable = [0 0; 0 1; 1 0; 1 1];
    %InitialRadius Initial search radius
    %   Specify the initial search radius for the decoding algorithm as one
    %   of 'Infinity' (default) or 'ZF solution'.  'Infinity' sets the
    %   initial search radius to Inf. 'ZF solution' sets the initial search
    %   radius to the zero-forcing solution, which is calculated by the
    %   pseudo-inverse of the input channel when decoding.
    InitialRadius = 'Infinity';
    %DecisionType Decision method
    %   Specify the decoding decision method as one of 'Soft' (default) or
    %   'Hard'. When set to 'Soft', the decoder outputs log-likelihood
    %   ratios (LLRs), i.e. 'soft bits'. When set to 'Hard', the decoder
    %   converts the soft LLRs to bits. The hard decision output logical
    %   array follows the mapping of a zero for a negative LLR and one
    %   for all other values.
    DecisionType = 'Soft';
end
    
properties (Access=private)
    pBitTableLogical = logical([0 0; 0 1; 1 0; 1 1]);
    pInitialDistanceIsZF = false;
end

% The possible values for InitialRadius and DecisionType
properties (Constant, Hidden)
    InitialRadiusSet = matlab.system.StringSet({'Infinity', 'ZF solution'});
    DecisionTypeSet  = matlab.system.StringSet({'Soft', 'Hard'}); 
end

methods
    % Class constructor
    function obj = SphereDecoder(varargin)
        setProperties(obj, nargin, varargin{:}, 'Constellation', ...
            'BitTable');
    end

    % Set class parameters
    % Comment out the use of validateattributes and coder.internal.errorif,
    % if repurposing the code for modifications to the existing algorithm.
    function set.Constellation(obj, value)
        propName = 'Constellation';
        validateattributes(value, {'double'}, {'nonempty', 'nonsparse', ...
            'column', 'finite'}, [class(obj) '.' propName], ...
            'Constellation'); 
        coder.internal.errorIf(isreal(value), ...
            'comm:SphereDecoder:ExpectedComplexConst');
        coder.internal.errorIf(log2(size(value,1)) == 0, ...
            'comm:SphereDecoder:InvalidConstellationLen');
        coder.internal.errorIf(log2(size(value,1)) ~= floor(log2(size(value,1))), ...
            'comm:SphereDecoder:InvalidConstellationLen');

        obj.Constellation = value;
    end

    function set.BitTable(obj, value)
        propName = 'BitTable';
        validateattributes(value, {'double'}, {'nonempty', 'nonsparse', ...
            'binary'}, [class(obj) '.' propName], 'BitTable'); 
        coder.internal.errorIf(log2(size(value,1))~=floor(log2(size(value,1))), ...
            'comm:SphereDecoder:InvalidBitTableLen');
        coder.internal.errorIf(log2(size(value,1))~=size(value,2), ...
            'comm:SphereDecoder:InconsistentBitTable');

        obj.BitTable = value;
    end
end

methods (Access = protected)

    %% Validate properties
    function validatePropertiesImpl(obj)
        coder.internal.errorIf(size(obj.Constellation, 1) ~= ...
        size(obj.BitTable, 1), 'comm:SphereDecoder:UnequalPropertyRows');
    
        coder.internal.errorIf(length(unique(obj.BitTable, 'rows')) ~= ...
            size(obj.BitTable,1), 'comm:SphereDecoder:NonUniqueBitTableRows');

        coder.internal.errorIf(length(unique(obj.Constellation)) ~= ...
            size(obj.Constellation,1), 'comm:SphereDecoder:NonUniqueConstellation');
    end

    %% Validate inputs
    function validateInputsImpl(obj, RxSymbols, Chan)
        % Type checks
        validateattributes(RxSymbols, {'double'}, {'nonsparse',...
             'finite', '2d'}, [class(obj) '.step'], 'RXSYMBOLS');
        if isempty(coder.target) || ~eml_ambiguous_complexity
            coder.internal.errorIf(isreal(RxSymbols), ...
             'comm:SphereDecoder:ExpectedComplexRxSymbols');
        end
        
        validateattributes(Chan, {'double'}, {'nonsparse', ...
            'finite'}, [class(obj) '.step'], 'CHAN'); 
        if isempty(coder.target) || ~eml_ambiguous_complexity
            coder.internal.errorIf(isreal(Chan), ...
             'comm:SphereDecoder:ExpectedComplexChan');
        end
        coder.internal.errorIf(( (ndims(Chan)~=3) && (ndims(Chan)~=2) ), ...
            'comm:SphereDecoder:InvalidChanDims');  %#ok

        % Size checks
        % Check that the dimensionality of Chan and RxSymbols correspond
         coder.internal.errorIf(size(Chan, 3) ~= size(RxSymbols, 2), ...
            'comm:SphereDecoder:UnequalNumRx');
        coder.internal.errorIf(size(Chan, 2)>size(RxSymbols, 2), ...
            'comm:SphereDecoder:NumTxGTNumRx');

        % Check the dimensionality of nSymb for the case when more than one
        % Chan is specified
        if ~(size(Chan, 1)==1) || size(RxSymbols, 1)==1
            coder.internal.errorIf(size(Chan, 1) ~= size(RxSymbols, 1), ...
                'comm:SphereDecoder:UnequalSymbols');
        end
    end

    %% Set number of inputs and outputs
    function numIn = getNumInputsImpl(~)
        numIn = 2;
    end

    function numOut = getNumOutputsImpl(~)
        numOut = 1;
    end

    %% Size propagators
    function flag = isInputSizeLockedImpl(~,~)
        flag = false; 
    end

    function varargout = isOutputFixedSizeImpl(obj)
        coder.internal.errorIf(inputFixedSize(obj, 1) ~= inputFixedSize(obj, 2), ...
            'comm:SphereDecoder:InvalidInputDimsMode');

        varargout = {inputFixedSize(obj, 1)};       
    end
    
    function varargout = getOutputSizeImpl(obj)
        kMod          = size(obj.BitTable, 2);
        rxSize        = inputSize(obj, 1);
        chanSize      = inputSize(obj, 2);
        varargout = {[rxSize(1)*kMod chanSize(2)]};  
    end
    
    %% Type propagators
    function varargout = getOutputDataTypeImpl(obj)
        if strcmp(obj.DecisionType, 'Soft')
            varargout = {inputDataType(obj, 1)};    
        else
            varargout = {'logical'};                
        end
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

    %% setupImpl
    function setupImpl(obj, varargin)  
        obj.pBitTableLogical = logical(obj.BitTable);
        obj.pInitialDistanceIsZF = strcmp(obj.InitialRadius, 'ZF solution');
    end

    %% stepImpl
    function LLRs_output = stepImpl(obj, RxSymbols, Chan)
        isSoftDecisionType = strcmp(obj.DecisionType, 'Soft');
        
        if isempty(Chan) || isempty(RxSymbols)
            % Empty input/s case
            Nt = size(Chan, 2);
            if isSoftDecisionType
                LLRs_output  = zeros(0, Nt);
            else
                LLRs_output  = false(0, Nt);
            end
        else
            %% Initialization
            constellation = obj.Constellation;
            bittable      = obj.pBitTableLogical;
            kMod          = size(bittable, 2);
            Ns            = size(RxSymbols, 1);
            Nt            = size(Chan, 2);

            %% Allocate output
            % Limited to using the same constellation on each TX antenna.
            kMods          = kMod(ones(1, Nt));
            constellations = constellation(:, ones(1, Nt));
            if isreal(constellations)
                constellations = complex(constellations, 0);
            end
            bittables      = bittable(:, :, ones(1, Nt));

            % QR decomposition
            [Qy_all, R_all, init_symbolIdxs, initialDistance] = ...
                 comm.SphereDecoder.precalculations(Chan, RxSymbols, ...
                    constellations, obj.pInitialDistanceIsZF);

            %% Decoding
            if isempty(coder.target) 
                % Tree search (using the MEX fcn)
                [LLRs, ~] = mwcomm_SphereDecoder(R_all, Qy_all, ...
                    uint32(Nt), uint32(Ns), initialDistance, ...
                    constellations, bittables, init_symbolIdxs, ...
                    uint32(kMods), isSoftDecisionType);
            else
                % Tree search (using MATLAB code)
                % Comment out the if/else/end statements to always use the 
                % MATLAB code and enable debugging
                [LLRs, ~] = comm.SphereDecoder.singleTreeSearch(...
                    R_all, Qy_all, uint32(Nt), uint32(Ns), ...
                    initialDistance, constellations, bittables,...
                    init_symbolIdxs, uint32(kMods), isSoftDecisionType);
            end

            if isSoftDecisionType
                LLRs_output = zeros(Ns*kMod, Nt);
            else % Hard decision
                LLRs_output = false(Ns*kMod, Nt);
            end
            % Convert output to the format used in the TX-RX chain
            for NtIdx = 1:Nt
                LLRs_output(:, NtIdx) = reshape(LLRs((1:kMod) + ...
                                                 kMod*(NtIdx-1),:), ...
                                                 Ns*kMod, 1);
            end
        end
    end
    
    %%
    function s = saveObjectImpl(obj)
        s = saveObjectImpl@matlab.System(obj);
        if isLocked(obj)
            s.pBitTableLogical     = obj.pBitTableLogical;
            s.pInitialDistanceIsZF = obj.pInitialDistanceIsZF;
        end
    end
    
    function loadObjectImpl(obj, s, wasLocked)
        if wasLocked
            obj.pBitTableLogical     = s.pBitTableLogical;
            obj.pInitialDistanceIsZF = s.pInitialDistanceIsZF;
        end
        % Call the base class method
        loadObjectImpl@matlab.System(obj, s);
    end
    
    function icon = getIconImpl(~)        
        icon = sprintf('Sphere\nDecoder');
    end
  
    function varargout = getInputNamesImpl(~)
        % Always have two inputs
        varargout = {'Rx', 'cEst'};
    end
  
end

methods(Static, Access = protected)
    function header = getHeaderImpl
        header = matlab.system.display.Header('comm.SphereDecoder', ...
            'Title', 'Sphere Decoder');
    end
end

methods(Static, Access=private)

    function [Qy_all, R_all, initSymbsIdxs, initialDistance] = ...
             precalculations(Chan, y, constellations, initialDistanceIsZF)
        % Precalculations prior to the Sphere decoding algorithm. Includes
        % QR decomposition and, if configured so, ZF solution.

        Nt              = size(Chan, 2);
        Nr              = size(Chan, 3);
        Ns              = size(y, 1);
        Qy_all          = complex(zeros(Nt, Ns), 0);
        R_all           = complex(zeros(Nt, Nt, Ns), 0);
        initSymbsIdxs   = ones(Nt, Ns, 'uint32');
        Q               = complex(zeros(Nr, Nt), 0);
        justOneQR       = size(Chan, 1)==1;
        H_symb          = complex(zeros(Nr, Nt));
        initialDistance = Inf(1, Ns);

        % MATLAB employs the [Nt Nr] convention. Reorder the dimensions 
        % of Chan to use the [nRX x nTX] convention used in the equations
        Chan = permute(Chan,[3 2 1]);
        y    = y.';
        
        if justOneQR
            H_symb(:) = Chan;
            
            % We do not need only-zero rows of R, so we take the
            % economy-size QR decomposition
            [Q(:), R]  = qr(H_symb, 0);
            R_all(:,:,:) = R(:, :, ones(1, Ns));
            
            for symbIdx = 1:Ns
                Qy_all(:, symbIdx) = Q'*y(:, symbIdx);
                
                % Calculate the initial search radius for the SSD
                if initialDistanceIsZF
                    [initialDistance(symbIdx), initSymbsIdxs(:,symbIdx)] =...
                        comm.SphereDecoder.ZFsolution(H_symb, y(:,symbIdx),...
                            constellations);
                end
            end
        else
           for symbIdx = 1:Ns
                % We do not need only-zero rows of R, so we take the
                % economy-size QR decomposition
                [Q(:), R_all(:, :, symbIdx)] = qr(Chan(:, :, symbIdx),0);
                Qy_all(:, symbIdx) = Q'*y(:, symbIdx);
                
                % Calculate the initial search radius for the SSD
                if initialDistanceIsZF
                    [initialDistance(symbIdx), initSymbsIdxs(:, symbIdx)] =...
                        comm.SphereDecoder.ZFsolution(Chan(:, :, symbIdx),...
                             y(:, symbIdx), constellations);
                end
            end
        end
        if isreal(R_all)
            R_all = complex(R_all, 0);
        end
        if isreal(Qy_all)
            Qy_all = complex(Qy_all, 0);
        end
    end

    function [dist, symbs] = ZFsolution(Chan, y, constellations)
        x_est_zf = Chan\y;
        Nt       = length(x_est_zf);
        x_init   = complex(zeros(Nt, 1), 0);
        symbs    = zeros(Nt, 1, 'uint32');
        for NtIdx = 1:Nt
            [~, symbs(NtIdx)] = min(abs(x_est_zf(NtIdx) - ...
                                         constellations(:, NtIdx)).^2);
            x_init(NtIdx) = constellations(symbs(NtIdx), NtIdx);
        end
        dist = sum(abs(y-Chan*x_init).^2);
    end

    
    function [currSymbsIdx, currLevel, nodeVisitingFinished] = ...
                STSGetNextNode(currSymbsIdx, currLevel, kMods)
        % Select the next symbol. If we reached the M-th symbol of the
        % level, we have to go up one (or many) levels. Hence the loop.

        while true
            if currSymbsIdx(currLevel) == 2^kMods(currLevel)
                % Not at the top
                if currLevel < length(currSymbsIdx)
                    % Reset the symbol idx for
                    currSymbsIdx(currLevel) = 1;
                    % Go up one level
                    currLevel = currLevel + 1;
                else
                    % We are back at the top. i.e., we traversed the whole
                    % tree
                    nodeVisitingFinished = true;
                    return
                end
            else
                currSymbsIdx(currLevel) = currSymbsIdx(currLevel) + 1;
                % Also covers the case when we moved up one level.
                % Then we also move one symbol position forward.
                nodeVisitingFinished = false;
                return
            end
        end
    end
        
    function [LLRs, visitedNodes] = singleTreeSearch(R, Qy, Nt, ...
                Ns, initial_radius, constellations, bittables, ...
                symbols_zf_idxs, kMods, isSoftDecision)
        % Reference: Employing the single-tree search (STS) algorithm.
        % C. Studer, M. Wenk, A. Burg, and H. Bolcskei, "Soft-Output Sphere
        % Decoding: Performance and Implementation Aspects", Proceedings of
        % the 40th Asilomar Conference on Signals, Systems, and Computers,
        % Oct. 2006, pp. 2071-2076.

        %% Allocate variables
        % Assume same number of bits are used for each TX antenna.
        %  Use totalBits = sum(kMods); % to allow different kMod per Tx
        totalBits    = kMods(1)*Nt;
        lambda_ch    = Inf(1, totalBits);
        distances    = zeros(Nt, 1);
        currSymbsIdx = ones(Nt, 1, 'uint32');
        currSymb     = complex(zeros(Nt, 1), 0);
        currBits     = false(1, totalBits);
    
        % The output
        if isSoftDecision
            LLRs = zeros(totalBits, Ns);
        else
            LLRs = false(totalBits, Ns);
        end
        visitedNodes = zeros(Ns, 1);
        
        for sIdx = 1:Ns
            %% Initialize variables
            nodeVisitingDone = false;
            % Initial value of the search radius
            lambda_ml       = initial_radius(sIdx);
            % Starting point (top)
            currLevel       = Nt;
            % Initialized to infinity
            lambda_ch(:)    = Inf;
            % ML symbols initialized to the ZF ones
            symbols_ml_idxs = symbols_zf_idxs(:, sIdx);
            distances(:)    = 0;
            currSymbsIdx(:) = 1;
            bits_ml         = false(1, totalBits);
            offsettBits     = zeros(1, Nt);
            for symbolIdx = 1:Nt
                bits_ml((1:kMods(symbolIdx))+offsettBits(symbolIdx))...
                    = bittables(symbols_ml_idxs(symbolIdx),...
                        1:kMods(symbolIdx), symbolIdx);
                if symbolIdx<Nt
                    offsettBits(symbolIdx+1) = offsettBits(symbolIdx) + ...
                                               kMods(symbolIdx);
                end
            end

            %% Begin traversing the tree
            while(~nodeVisitingDone)
                % Calculate the current symbols and the current bits
                for symbolIdx = 1:Nt
                    currSymb(symbolIdx) = constellations(...
                                      currSymbsIdx(symbolIdx),symbolIdx);

                    currBits((1:kMods(symbolIdx)) + ...
                        offsettBits(symbolIdx)) = ...
                        bittables(currSymbsIdx(symbolIdx), ...
                                    1:kMods(symbolIdx), symbolIdx);
                end

                % Calculate current weight (skip zero values)
                e_i  = abs(Qy(currLevel, sIdx) - sum(R(currLevel, ...
                       currLevel:Nt, sIdx).* currSymb(currLevel:Nt).'))^2;

                % Increase the visitedNodes counter
                visitedNodes(sIdx) = visitedNodes(sIdx)+1;

                % Add the accumulated partial distance
                if currLevel==Nt
                    distances(Nt) = e_i;
                else
                    distances(currLevel) = distances(currLevel+1) + e_i;
                end

                % Decide where to go next
                if currLevel>1
                    % Bottom not yet reached
                    if distances(currLevel) < lambda_ml
                        % Continue searching for a new hypothesis:
                        %   Go one level down
                        currLevel = currLevel - 1;
                    else
                        if isSoftDecision
                            % Check if there is the possibility of a smaller
                            % CH in the subtree following the node
    
                            % For layers we did not yet traverse, we just take
                            % the maximum (no CH evaluation needed, as all
                            % would be valid)
                            bitsNotTraversedEnd = sum(kMods(1,1:(currLevel-1)));
                            lambda_ch_max = ...
                                max(lambda_ch(1:bitsNotTraversedEnd));
    
                            % For the layers we already traversed, check
                            % whether the CH is valid
                            lambda_ch_toConsider = ...
                                lambda_ch(bitsNotTraversedEnd+1:totalBits);
                            bitsDifferentTo_ml = ...
                                currBits(bitsNotTraversedEnd+1:totalBits)~=...
                                    bits_ml(bitsNotTraversedEnd+1:totalBits);
                            lambda_ch_max = max([lambda_ch_max ...
                                lambda_ch_toConsider(bitsDifferentTo_ml)]);
    
                            if distances(currLevel) < lambda_ch_max
                                % Continue searching counter-hypotheses:
                                %   Go one level down
                                currLevel = currLevel - 1;
                            else
                                % Go to the next node sideways and/or upwards
                                [currSymbsIdx, currLevel, ...
                                     nodeVisitingDone] = ...
                                    comm.SphereDecoder.STSGetNextNode(...
                                        currSymbsIdx,currLevel,kMods);
                            end
                        else    
                            % Go to the next node sideways and/or upwards
                            [currSymbsIdx, currLevel, nodeVisitingDone] = ...
                                comm.SphereDecoder.STSGetNextNode(...
                                    currSymbsIdx,currLevel,kMods);
                        end                                                    
                    end
                else
                    % Bottom reached
                    if distances(currLevel) < lambda_ml
                        if isSoftDecision
                            % Update the counter-hypotheses.
                            % This hypothesis is a valid counter-hypothesis
                            lambda_ch(currBits~=bits_ml) = lambda_ml;
                        end
                        
                        % Update the hypothesis
                        lambda_ml       = distances(currLevel);
                        bits_ml(:)      = currBits;
                    else
                        if isSoftDecision
                            % Update the counter-hypotheses
                            lambda_ch((currBits~=bits_ml) &...
                                (lambda_ch>distances(currLevel))) = ...
                                distances(currLevel);
                        end                            
                    end
                    % Go to the next node sideways and/or upwards
                    [currSymbsIdx, currLevel, nodeVisitingDone] = ...
                        comm.SphereDecoder.STSGetNextNode( ...
                            currSymbsIdx,currLevel,kMods);
                end
            end

            % Output
            if isSoftDecision
                % Calculate LLRs
                LLRs(bits_ml, sIdx)  = lambda_ch(bits_ml) - lambda_ml;
                LLRs(~bits_ml, sIdx) = lambda_ml - lambda_ch(~bits_ml);
            else % Hard
                % Output bits
                LLRs(bits_ml, sIdx)  = true;
                LLRs(~bits_ml, sIdx) = false;
            end
        end
    end
    
end

end

% [EOF]
