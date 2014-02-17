classdef DAWGN< handle
%DAWGN
%   This is a sub-system used by comm.AWGNChannel
%
%   H = comm.internal.DAWGN creates a dynamic additive white Gaussian noise
%   System object, H, that adds white Gaussian noise to the input.
%
%   Step syntax:
%
%   Y = step(H,X,NOISE,VAR) adds random noise to X producing Y. The noise
%   can have variance VAR, or another variance set by the configuration.
%   NOISE is unit variance Gaussian Random Data generated externally to the
%   DAWGN System object. Inputs X, NOISE, and VAR must have the same data
%   type which can be double or single precision.
%
%   DAWGN methods:
%
%   step     - Add white Gaussian noise to input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create a DAWGN object with same property values
%   isLocked - Locked status (logical)
%
%   DAWGN properties:
% 
%   NoiseMethodIndex     - Noise method index
%   EbNo                 - Energy per bit to noise power spectral density
%                          ratio (Eb/No) in dB
%   EsNo                 - Energy per symbol to noise power spectral
%                          density ratio (Es/No) in dB
%   SNR                  - Signal to noise ratio (SNR) in dB
%   BitsPerSymbol        - Number of bits in one symbol
%   SignalPower          - Input signal power in Watts
%   SamplesPerSymbol     - Number of samples per symbol
%   Variance             - Noise variance
%
%   See also comm.AWGNChannel.

 
%   Copyright 2008-2010 The MathWorks, Inc.

    methods
        function out=DAWGN
            %DAWGN
            %   This is a sub-system used by comm.AWGNChannel
            %
            %   H = comm.internal.DAWGN creates a dynamic additive white Gaussian noise
            %   System object, H, that adds white Gaussian noise to the input.
            %
            %   Step syntax:
            %
            %   Y = step(H,X,NOISE,VAR) adds random noise to X producing Y. The noise
            %   can have variance VAR, or another variance set by the configuration.
            %   NOISE is unit variance Gaussian Random Data generated externally to the
            %   DAWGN System object. Inputs X, NOISE, and VAR must have the same data
            %   type which can be double or single precision.
            %
            %   DAWGN methods:
            %
            %   step     - Add white Gaussian noise to input signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create a DAWGN object with same property values
            %   isLocked - Locked status (logical)
            %
            %   DAWGN properties:
            % 
            %   NoiseMethodIndex     - Noise method index
            %   EbNo                 - Energy per bit to noise power spectral density
            %                          ratio (Eb/No) in dB
            %   EsNo                 - Energy per symbol to noise power spectral
            %                          density ratio (Es/No) in dB
            %   SNR                  - Signal to noise ratio (SNR) in dB
            %   BitsPerSymbol        - Number of bits in one symbol
            %   SignalPower          - Input signal power in Watts
            %   SamplesPerSymbol     - Number of samples per symbol
            %   Variance             - Noise variance
            %
            %   See also comm.AWGNChannel.
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
end
