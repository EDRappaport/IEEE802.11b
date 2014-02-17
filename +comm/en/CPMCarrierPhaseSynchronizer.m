classdef CPMCarrierPhaseSynchronizer< handle
%CPMCarrierPhaseSynchronizer Recover carrier phase of baseband CPM signal
%   H = comm.CPMCarrierPhaseSynchronizer creates a CPM carrier phase
%   synchronizer System object, H. This object recovers the carrier phase of
%   a baseband continuous phase modulation (CPM), minimum shift keying
%   (MSK), continuous phase frequency shift keying (CPFSK), or Gaussian
%   minimum shift keying (GMSK) modulated signal using the 2P-power method.
%
%   H = comm.CPMCarrierPhaseSynchronizer(Name,Value) creates a CPM carrier
%   phase synchronizer object, H, with the specified property Name set to
%   the specified Value. You can specify additional name-value pair
%   arguments in any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.CPMCarrierPhaseSynchronizer(HALFPOW,Name,Value) creates a CPM
%   carrier phase synchronizer object, H, with the P property set to HALFPOW
%   and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   [Y,PH] = step(H,X) recovers the carrier phase of the input signal, X,
%   and returns the phase corrected signal, Y, and the carrier phase
%   estimate (in degrees), PH. X must be a complex scalar or column vector
%   input signal of data type single or double, with length equal to the 
%   ObservationInterval property value of H.
%
%   CPMCarrierPhaseSynchronizer methods:
%
%   step     - Recover carrier phase of baseband CPM signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create CPM carrier phase synchronizer object with same 
%              property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the CPM carrier phase synchronizer object
%
%   CPMCarrierPhaseSynchronizer properties:
%
%   P                   - Denominator of CPM modulation index
%   ObservationInterval - Number of symbols where carrier phase assumed 
%                         constant
%
%   % Example:
%   %   Recover carrier phase of a CPM signal using 2P-power method
%
%   M = 16;
%   P = 2;
%   phOffset = 10*pi/180;  % in radians
%   numSamples = 100;
%   % Create CPM modulator System object
%   hMod = comm.CPMModulator(M, 'InitialPhaseOffset',phOffset, ...
%           'BitInput',true, 'ModulationIndex',1/P, 'SamplesPerSymbol',1);
%   % Create CPM carrier phase synchronizer System object. Assume every 50
%   % samples have the same carrier phase.
%   hSync = comm.CPMCarrierPhaseSynchronizer(P,...
%           'ObservationInterval',numSamples/2);
%   % Generate random binary data
%   data = randi([0 1],numSamples*log2(M),1);
%   % Modulate random data and add carrier phase
%   modData = step(hMod, data);
%   % Recover the carrier phase
%   recSig = zeros(numSamples,1); phEst = zeros(2,1);
%   for i = 1:2
%       idx = (i-1)*numSamples/2+1: i*numSamples/2;
%       [recSig(idx), phEst(i)] = step(hSync, modData(idx));
%   end
%   fprintf(['The carrier phase for the first %d samples is ', ...
%       'estimated to be %g degrees.\n'], numSamples/2, phEst(1));
%   fprintf(['The carrier phase for the second %d samples is ', ...
%       'estimated to be %g degrees.\n'], numSamples/2, phEst(2));
%
%   See also comm.PSKCarrierPhaseSynchronizer, comm.CPMModulator.

 
%   Copyright 2010-2013 The MathWorks, Inc.

    methods
        function out=CPMCarrierPhaseSynchronizer
            %CPMCarrierPhaseSynchronizer Recover carrier phase of baseband CPM signal
            %   H = comm.CPMCarrierPhaseSynchronizer creates a CPM carrier phase
            %   synchronizer System object, H. This object recovers the carrier phase of
            %   a baseband continuous phase modulation (CPM), minimum shift keying
            %   (MSK), continuous phase frequency shift keying (CPFSK), or Gaussian
            %   minimum shift keying (GMSK) modulated signal using the 2P-power method.
            %
            %   H = comm.CPMCarrierPhaseSynchronizer(Name,Value) creates a CPM carrier
            %   phase synchronizer object, H, with the specified property Name set to
            %   the specified Value. You can specify additional name-value pair
            %   arguments in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.CPMCarrierPhaseSynchronizer(HALFPOW,Name,Value) creates a CPM
            %   carrier phase synchronizer object, H, with the P property set to HALFPOW
            %   and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   [Y,PH] = step(H,X) recovers the carrier phase of the input signal, X,
            %   and returns the phase corrected signal, Y, and the carrier phase
            %   estimate (in degrees), PH. X must be a complex scalar or column vector
            %   input signal of data type single or double, with length equal to the 
            %   ObservationInterval property value of H.
            %
            %   CPMCarrierPhaseSynchronizer methods:
            %
            %   step     - Recover carrier phase of baseband CPM signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create CPM carrier phase synchronizer object with same 
            %              property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the CPM carrier phase synchronizer object
            %
            %   CPMCarrierPhaseSynchronizer properties:
            %
            %   P                   - Denominator of CPM modulation index
            %   ObservationInterval - Number of symbols where carrier phase assumed 
            %                         constant
            %
            %   % Example:
            %   %   Recover carrier phase of a CPM signal using 2P-power method
            %
            %   M = 16;
            %   P = 2;
            %   phOffset = 10*pi/180;  % in radians
            %   numSamples = 100;
            %   % Create CPM modulator System object
            %   hMod = comm.CPMModulator(M, 'InitialPhaseOffset',phOffset, ...
            %           'BitInput',true, 'ModulationIndex',1/P, 'SamplesPerSymbol',1);
            %   % Create CPM carrier phase synchronizer System object. Assume every 50
            %   % samples have the same carrier phase.
            %   hSync = comm.CPMCarrierPhaseSynchronizer(P,...
            %           'ObservationInterval',numSamples/2);
            %   % Generate random binary data
            %   data = randi([0 1],numSamples*log2(M),1);
            %   % Modulate random data and add carrier phase
            %   modData = step(hMod, data);
            %   % Recover the carrier phase
            %   recSig = zeros(numSamples,1); phEst = zeros(2,1);
            %   for i = 1:2
            %       idx = (i-1)*numSamples/2+1: i*numSamples/2;
            %       [recSig(idx), phEst(i)] = step(hSync, modData(idx));
            %   end
            %   fprintf(['The carrier phase for the first %d samples is ', ...
            %       'estimated to be %g degrees.\n'], numSamples/2, phEst(1));
            %   fprintf(['The carrier phase for the second %d samples is ', ...
            %       'estimated to be %g degrees.\n'], numSamples/2, phEst(2));
            %
            %   See also comm.PSKCarrierPhaseSynchronizer, comm.CPMModulator.
        end

    end
    methods (Abstract)
    end
    properties
        %P      Denominator of CPM modulation index
        %   Specify the denominator of the CPM modulation index of the input
        %   signal as a real positive scalar integer value of data type single or
        %   double. The default is 2. This property is tunable.
        P;

    end
end
