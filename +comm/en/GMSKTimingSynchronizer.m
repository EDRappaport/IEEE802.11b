classdef GMSKTimingSynchronizer< handle
%GMSKTimingSynchronizer Recover symbol timing phase using fourth-order
%nonlinearity method 
%   H = comm.GMSKTimingSynchronizer creates a timing phase synchronizer
%   System object, H. The object recovers the symbol timing phase of 
%   the GMSK input signal using a fourth-order nonlinearity method. 
%   GMSK timing synchronization is a general non-data-aided feedback  
%   method. It is independent of carrier phase recovery but requires 
%   prior compensation of the carrier frequency offset. You typically  
%   use this method for systems that use baseband Gaussian minimum shift 
%   keying (GMSK) modulation.
%
%   H = comm.GMSKTimingSynchronizer(Name,Value) creates a GMSK timing
%   synchronizer object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments
%    in any order as (Name1,Value1,...,NameN,ValueN).
%
%
%   Step method syntax:
%
%   [Y,PHASE] = step(H,X) performs timing phase recovery and returns the
%   time-synchronized signal, Y, and the estimated timing phase, PHASE, for
%   input signal X. X must be a double or single precision complex column
%   vector.
%
%   [Y,PHASE] = step(H,X,R) restarts the timing phase recovery process when
%   you input a reset signal, R, that is non-zero. R must be a logical or 
%   double scalar. This syntax applies when you set the ResetInputPort 
%   property to true.
%
%   GMSKTimingSynchronizer methods:
%
%   step     - Recover timing phase (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create GMSK timing phase synchronizer object with same 
%              property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of GMSK timing phase synchronizer object
%
%   GMSKTimingSynchronizer properties:
%
%   SamplesPerSymbol - Number of samples representing each symbol
%   ErrorUpdateGain  - Error update step size
%   ResetInputPort   - Enable synchronization reset input
%   ResetCondition   - Condition for timing phase recovery reset
%
%   % Example:
%   %   Recover timing phase of an MSK signal
%
%   % Create System objects  
%   hMod = comm.GMSKModulator('BitInput', true, ...
%                   'SamplesPerSymbol', 14);
%   timingOffset = 0.2; % Actual timing offset
%   hDelay = dsp.VariableFractionalDelay;
%   hSync = comm.GMSKTimingSynchronizer('SamplesPerSymbol', 14, ...
%                   'ErrorUpdateGain', 0.05);
%   phEst = zeros(1, 10);
%   for i = 1:51
%     data = randi([0 1], 100, 1); % generate data
%     modData = step(hMod, data); % modulate data
%     % data impaired by timing offset error
%     impairedData = step(hDelay, modData, timingOffset*14); 
%     % perform timing phase recovery
%     [y, phase] = step(hSync, impairedData); 
%     phEst(i) = phase(1)/14;
%   end
%   figure, plot(0.2*ones(1, 50));
%   hold on; ylim([0 0.4])
%   plot(phEst, 'r'); legend( 'original', 'estimated')
%   title('Original and Estimated timing phases');
%
%   See also comm.EarlyLateGateTimingSynchronizer, 
%            comm.MuellerMullerTimingSynchronizer.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=GMSKTimingSynchronizer
            %GMSKTimingSynchronizer Recover symbol timing phase using fourth-order
            %nonlinearity method 
            %   H = comm.GMSKTimingSynchronizer creates a timing phase synchronizer
            %   System object, H. The object recovers the symbol timing phase of 
            %   the GMSK input signal using a fourth-order nonlinearity method. 
            %   GMSK timing synchronization is a general non-data-aided feedback  
            %   method. It is independent of carrier phase recovery but requires 
            %   prior compensation of the carrier frequency offset. You typically  
            %   use this method for systems that use baseband Gaussian minimum shift 
            %   keying (GMSK) modulation.
            %
            %   H = comm.GMSKTimingSynchronizer(Name,Value) creates a GMSK timing
            %   synchronizer object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments
            %    in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %
            %   Step method syntax:
            %
            %   [Y,PHASE] = step(H,X) performs timing phase recovery and returns the
            %   time-synchronized signal, Y, and the estimated timing phase, PHASE, for
            %   input signal X. X must be a double or single precision complex column
            %   vector.
            %
            %   [Y,PHASE] = step(H,X,R) restarts the timing phase recovery process when
            %   you input a reset signal, R, that is non-zero. R must be a logical or 
            %   double scalar. This syntax applies when you set the ResetInputPort 
            %   property to true.
            %
            %   GMSKTimingSynchronizer methods:
            %
            %   step     - Recover timing phase (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create GMSK timing phase synchronizer object with same 
            %              property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of GMSK timing phase synchronizer object
            %
            %   GMSKTimingSynchronizer properties:
            %
            %   SamplesPerSymbol - Number of samples representing each symbol
            %   ErrorUpdateGain  - Error update step size
            %   ResetInputPort   - Enable synchronization reset input
            %   ResetCondition   - Condition for timing phase recovery reset
            %
            %   % Example:
            %   %   Recover timing phase of an MSK signal
            %
            %   % Create System objects  
            %   hMod = comm.GMSKModulator('BitInput', true, ...
            %                   'SamplesPerSymbol', 14);
            %   timingOffset = 0.2; % Actual timing offset
            %   hDelay = dsp.VariableFractionalDelay;
            %   hSync = comm.GMSKTimingSynchronizer('SamplesPerSymbol', 14, ...
            %                   'ErrorUpdateGain', 0.05);
            %   phEst = zeros(1, 10);
            %   for i = 1:51
            %     data = randi([0 1], 100, 1); % generate data
            %     modData = step(hMod, data); % modulate data
            %     % data impaired by timing offset error
            %     impairedData = step(hDelay, modData, timingOffset*14); 
            %     % perform timing phase recovery
            %     [y, phase] = step(hSync, impairedData); 
            %     phEst(i) = phase(1)/14;
            %   end
            %   figure, plot(0.2*ones(1, 50));
            %   hold on; ylim([0 0.4])
            %   plot(phEst, 'r'); legend( 'original', 'estimated')
            %   title('Original and Estimated timing phases');
            %
            %   See also comm.EarlyLateGateTimingSynchronizer, 
            %            comm.MuellerMullerTimingSynchronizer.
        end

    end
    methods (Abstract)
    end
end
