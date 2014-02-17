classdef PSKCarrierPhaseSynchronizer< handle
%PSKCarrierPhaseSynchronizer Recover baseband PSK signal's carrier phase
%   H = comm.PSKCarrierPhaseSynchronizer creates a PSK carrier phase
%   synchronizer System object, H. This object recovers the carrier phase of
%   a baseband phase shift keying (PSK) modulated signal using the M-power
%   method.
%
%   H = comm.PSKCarrierPhaseSynchronizer(Name,Value) creates a PSK carrier
%   phase synchronizer object, H, with the specified property Name set to
%   the specified Value. You can specify additional name-value pair
%   arguments in any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.PSKCarrierPhaseSynchronizer(M,Name,Value) creates a PSK carrier
%   phase synchronizer object, H, with the ModulationOrder property set to M
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
%   PSKCarrierPhaseSynchronizer methods:
%
%   step     - Recover baseband PSK signal carrier phase (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create PSK carrier phase synchronizer object with same 
%              property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the PSK carrier phase synchronizer object
%
%   PSKCarrierPhaseSynchronizer properties:
%
%   ModulationOrder     - Number of points in signal constellation
%   ObservationInterval - Number of symbols where carrier phase assumed 
%                         constant
%
%   % Example:
%   %   Recover carrier phase of a 16-PSK signal using M-power method
%
%   M = 16;
%   phOffset = 10*pi/180;  % in radians
%   numSamples = 100;
%   % Create PSK modulator System object
%   hMod = comm.PSKModulator(M,phOffset,'BitInput',false);
%   % Create PSK carrier phase synchronizer System object. Assume every 50
%   % samples have the same carrier phase.
%   hSync = comm.PSKCarrierPhaseSynchronizer(M,...
%                       'ObservationInterval',numSamples/2);
%   % Generate random data
%   data = randi([0 M-1],numSamples,1);
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
%   See also comm.CPMCarrierPhaseSynchronizer, comm.PSKModulator.

 
%   Copyright 2010-2013 The MathWorks, Inc.

    methods
        function out=PSKCarrierPhaseSynchronizer
            %PSKCarrierPhaseSynchronizer Recover baseband PSK signal's carrier phase
            %   H = comm.PSKCarrierPhaseSynchronizer creates a PSK carrier phase
            %   synchronizer System object, H. This object recovers the carrier phase of
            %   a baseband phase shift keying (PSK) modulated signal using the M-power
            %   method.
            %
            %   H = comm.PSKCarrierPhaseSynchronizer(Name,Value) creates a PSK carrier
            %   phase synchronizer object, H, with the specified property Name set to
            %   the specified Value. You can specify additional name-value pair
            %   arguments in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.PSKCarrierPhaseSynchronizer(M,Name,Value) creates a PSK carrier
            %   phase synchronizer object, H, with the ModulationOrder property set to M
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
            %   PSKCarrierPhaseSynchronizer methods:
            %
            %   step     - Recover baseband PSK signal carrier phase (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create PSK carrier phase synchronizer object with same 
            %              property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the PSK carrier phase synchronizer object
            %
            %   PSKCarrierPhaseSynchronizer properties:
            %
            %   ModulationOrder     - Number of points in signal constellation
            %   ObservationInterval - Number of symbols where carrier phase assumed 
            %                         constant
            %
            %   % Example:
            %   %   Recover carrier phase of a 16-PSK signal using M-power method
            %
            %   M = 16;
            %   phOffset = 10*pi/180;  % in radians
            %   numSamples = 100;
            %   % Create PSK modulator System object
            %   hMod = comm.PSKModulator(M,phOffset,'BitInput',false);
            %   % Create PSK carrier phase synchronizer System object. Assume every 50
            %   % samples have the same carrier phase.
            %   hSync = comm.PSKCarrierPhaseSynchronizer(M,...
            %                       'ObservationInterval',numSamples/2);
            %   % Generate random data
            %   data = randi([0 M-1],numSamples,1);
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
            %   See also comm.CPMCarrierPhaseSynchronizer, comm.PSKModulator.
        end

    end
    methods (Abstract)
    end
    properties
        %ModulationOrder Number of points in signal constellation
        %   Specify the modulation order of the input signal as an even, positive,
        %   real scalar value of data type single or double. The default is 2.
        %   This property is tunable.
        ModulationOrder;

    end
end
