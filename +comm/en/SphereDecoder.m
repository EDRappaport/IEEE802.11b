classdef SphereDecoder< handle
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

    methods
        function out=SphereDecoder
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
        end

        function getHeaderImpl(in) %#ok<MANU>
        end

        function getIconImpl(in) %#ok<MANU>
        end

        function getInputNamesImpl(in) %#ok<MANU>
            % Always have two inputs
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function getNumOutputsImpl(in) %#ok<MANU>
        end

        function getOutputDataTypeImpl(in) %#ok<MANU>
        end

        function getOutputSizeImpl(in) %#ok<MANU>
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isOutputFixedSizeImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
            % Type checks
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BitTable Bit mapping per constellation point
        %   Specify the bit mapping for the symbols specified in the
        %   Constellation property as a numerical matrix. The matrix size 
        %   must be [ConstellationLength bitsPerSymbol], where
        %   ConstellationLength represents the length of the Constellation
        %   property value and bitsPerSymbol represents the number of bits that
        %   each symbol encodes. The default is [0 0; 0 1; 1 0; 1 1], which
        %   matches the default Constellation property value.
        BitTable;

        %Constellation Signal constellation
        %   Specify the constellation as a complex column vector containing the
        %   constellation points to which the transmitted bits are mapped. The
        %   length of the vector must be a power of two. The object assumes
        %   the same constellation is used for each transmit antenna. The
        %   default is a QPSK constellation with an average power of 1.
        Constellation;

        %DecisionType Decision method
        %   Specify the decoding decision method as one of 'Soft' (default) or
        %   'Hard'. When set to 'Soft', the decoder outputs log-likelihood
        %   ratios (LLRs), i.e. 'soft bits'. When set to 'Hard', the decoder
        %   converts the soft LLRs to bits. The hard decision output logical
        %   array follows the mapping of a zero for a negative LLR and one
        %   for all other values.
        DecisionType;

        %InitialRadius Initial search radius
        %   Specify the initial search radius for the decoding algorithm as one
        %   of 'Infinity' (default) or 'ZF solution'.  'Infinity' sets the
        %   initial search radius to Inf. 'ZF solution' sets the initial search
        %   radius to the zero-forcing solution, which is calculated by the
        %   pseudo-inverse of the input channel when decoding.
        InitialRadius;

    end
end
