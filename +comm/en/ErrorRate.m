classdef ErrorRate< handle
%ErrorRate Compute bit or symbol error rate of input data
%   H = comm.ErrorRate creates an error rate calculator System object, H.
%   This object computes the error rate of the received data by comparing it
%   to the transmitted data.
%
%   H = comm.ErrorRate(Name,Value) creates an error rate calculator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   The error rate is a running statistic that is the total number of
%   unequal pairs of data elements divided by the total number of input data
%   elements from one source. You can use this object to compute either
%   symbol or bit error rate, since it does not consider the magnitude of
%   the difference between input data elements. If the inputs are bits, then
%   the object computes the bit error rate. If the inputs are symbols, then
%   it computes the symbol error rate.
%
%   Step method syntax:
%
%   Y = step(H,TX,RX) counts the number of differences between the
%   transmitted data vector, TX, and received data vector, RX. The step
%   method outputs a three-element vector consisting of the error rate,
%   followed by the number of errors detected and the total number of
%   samples compared. TX and RX inputs can be either scalars or column
%   vectors of the same data type. Valid data types are single, double,
%   integer or logical. If TX is a scalar and RX is a vector, or vice-versa,
%   then the object compares the scalar with each element of the vector.
%
%   Y = step(H,TX,RX,SEL) calculates the errors based on selected samples
%   from the input frame specified by the SEL input. SEL must be a real,
%   double-precision integer valued scalar or a column vector. The vector
%   lists the indices of the elements of the RX input vector that the object
%   should consider when making comparisons. If the SEL input includes
%   zeros, then the object ignores them. This syntax applies when you set
%   the Samples property to 'Input Port'.
%
%   Y = step(H,TX,RX,RST) resets the error count whenever the input RST is
%   non-zero. RST must be a real, double, or logical scalar. When you set
%   the RST input to a nonzero value, the object clears its error statistics
%   and then recomputes them based on the current TX and RX inputs. This
%   syntax applies when you set the ResetInputPort property to true.
%
%   You can combine optional input arguments when their enabling properties
%   are set. Optional inputs must be listed in the same order as the order
%   of the enabling properties. For example,
%
%   Y = step(H,TX,RX,SEL,RST)
%
%   ErrorRate methods:
%
%   step     - Compute bit or symbol error rate of input data (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create error rate calculator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of error rate calculator object
%
%   ErrorRate properties:
%
%   ReceiveDelay     - Number of samples to delay transmitted signal
%   ComputationDelay - Computation delay
%   Samples          - Samples to consider
%   CustomSamples    - Selected samples from frame
%   ResetInputPort   - Enable error rate reset input
%
%   % Example:
%   %   Calculate BER between transmitted and received signal
%
%   % Use 8-DPSK modulation in an AWGN channel
%   hMod = comm.DPSKModulator('ModulationOrder',8,'BitInput',true);
%   hDemod = comm.DPSKDemodulator('ModulationOrder',8,'BitOutput',true);
%   hAWGN = comm.AWGNChannel('NoiseMethod',...
%                        'Signal to noise ratio (SNR)','SNR', 7);
%   % Create an error rate calculator, accounting for the three bit (i.e., 
%   % one symbol) transient caused by the differential modulation
%   hError = comm.ErrorRate('ComputationDelay',3);
%   BER = zeros(10,1);
%   % calculate BER for 10 frames
%   for i= 1:10
%       data = randi([0 1], 96, 1);
%       modData = step(hMod, data);
%       receivedSignal = step(hAWGN, modData);
%       receivedData = step(hDemod, receivedSignal);
%       errors = step(hError, data, receivedData);
%       BER(i) = errors(1);
%   end
%   disp(BER) % display BER for 10 frames
%
%   See also alignsignals, finddelay.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=ErrorRate
            %ErrorRate Compute bit or symbol error rate of input data
            %   H = comm.ErrorRate creates an error rate calculator System object, H.
            %   This object computes the error rate of the received data by comparing it
            %   to the transmitted data.
            %
            %   H = comm.ErrorRate(Name,Value) creates an error rate calculator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   The error rate is a running statistic that is the total number of
            %   unequal pairs of data elements divided by the total number of input data
            %   elements from one source. You can use this object to compute either
            %   symbol or bit error rate, since it does not consider the magnitude of
            %   the difference between input data elements. If the inputs are bits, then
            %   the object computes the bit error rate. If the inputs are symbols, then
            %   it computes the symbol error rate.
            %
            %   Step method syntax:
            %
            %   Y = step(H,TX,RX) counts the number of differences between the
            %   transmitted data vector, TX, and received data vector, RX. The step
            %   method outputs a three-element vector consisting of the error rate,
            %   followed by the number of errors detected and the total number of
            %   samples compared. TX and RX inputs can be either scalars or column
            %   vectors of the same data type. Valid data types are single, double,
            %   integer or logical. If TX is a scalar and RX is a vector, or vice-versa,
            %   then the object compares the scalar with each element of the vector.
            %
            %   Y = step(H,TX,RX,SEL) calculates the errors based on selected samples
            %   from the input frame specified by the SEL input. SEL must be a real,
            %   double-precision integer valued scalar or a column vector. The vector
            %   lists the indices of the elements of the RX input vector that the object
            %   should consider when making comparisons. If the SEL input includes
            %   zeros, then the object ignores them. This syntax applies when you set
            %   the Samples property to 'Input Port'.
            %
            %   Y = step(H,TX,RX,RST) resets the error count whenever the input RST is
            %   non-zero. RST must be a real, double, or logical scalar. When you set
            %   the RST input to a nonzero value, the object clears its error statistics
            %   and then recomputes them based on the current TX and RX inputs. This
            %   syntax applies when you set the ResetInputPort property to true.
            %
            %   You can combine optional input arguments when their enabling properties
            %   are set. Optional inputs must be listed in the same order as the order
            %   of the enabling properties. For example,
            %
            %   Y = step(H,TX,RX,SEL,RST)
            %
            %   ErrorRate methods:
            %
            %   step     - Compute bit or symbol error rate of input data (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create error rate calculator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of error rate calculator object
            %
            %   ErrorRate properties:
            %
            %   ReceiveDelay     - Number of samples to delay transmitted signal
            %   ComputationDelay - Computation delay
            %   Samples          - Samples to consider
            %   CustomSamples    - Selected samples from frame
            %   ResetInputPort   - Enable error rate reset input
            %
            %   % Example:
            %   %   Calculate BER between transmitted and received signal
            %
            %   % Use 8-DPSK modulation in an AWGN channel
            %   hMod = comm.DPSKModulator('ModulationOrder',8,'BitInput',true);
            %   hDemod = comm.DPSKDemodulator('ModulationOrder',8,'BitOutput',true);
            %   hAWGN = comm.AWGNChannel('NoiseMethod',...
            %                        'Signal to noise ratio (SNR)','SNR', 7);
            %   % Create an error rate calculator, accounting for the three bit (i.e., 
            %   % one symbol) transient caused by the differential modulation
            %   hError = comm.ErrorRate('ComputationDelay',3);
            %   BER = zeros(10,1);
            %   % calculate BER for 10 frames
            %   for i= 1:10
            %       data = randi([0 1], 96, 1);
            %       modData = step(hMod, data);
            %       receivedSignal = step(hAWGN, modData);
            %       receivedData = step(hDemod, receivedSignal);
            %       errors = step(hError, data, receivedData);
            %       BER(i) = errors(1);
            %   end
            %   disp(BER) % display BER for 10 frames
            %
            %   See also alignsignals, finddelay.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %ComputationDelay Computation delay
        %   Specify the number of data samples that the object should ignore at
        %   the beginning of the comparison, as a real, non-negative, double
        %   precision, integer scalar. Use this property to ignore the transient
        %   behavior of both input signals. The default is 0.
        ComputationDelay;

        %CustomSamples Selected samples from frame
        %   Specify a scalar or a column vector of double precision, real,
        %   non-negative integers that lists the indices of the elements of the RX
        %   frame vector that the object uses when making comparisons. If this
        %   property includes zeros, then the object ignores them. This property
        %   applies when you set the Samples property to 'Custom'. The default is
        %   an empty vector, which specifies that all samples are used.
        CustomSamples;

        %ReceiveDelay Number of samples to delay transmitted signal
        %   Specify the number of samples by which the received data lags behind
        %   the transmitted data as a real, non-negative, double precision,
        %   integer scalar. Use this property to align the samples that should be
        %   compared in the transmitted and received input data vectors. Specify
        %   the delay in number of samples, regardless of whether the input is a
        %   scalar or a vector. The default is 0.
        ReceiveDelay;

        %ResetInputPort Enable error rate reset input
        %   Set the ResetInputPort property to true to reset the error statistics
        %   via an input to the step method. The default is false.
        ResetInputPort;

        %Samples Samples to consider
        %   Specify samples to consider as one of 'Entire frame' | 'Custom' |
        %   'Input port'. The property defines whether the object should consider
        %   all or only part of the input frames when computing error statistics.
        %   The default is 'Entire frame'. Select 'Entire frame' to compare all
        %   the samples of the RX frame to those of the TX frame. Select 'Custom'
        %   or 'Input port' to list the indices of the RX frame elements that the
        %   object should consider when making comparisons. You list the indices
        %   as a scalar or a column vector of double precision integers through
        %   the CustomSamples property when you set the Samples property to
        %   'Custom'. You list the indices as an input to the step method, when
        %   you set the Samples property to 'Input port'.
        Samples;

    end
end
