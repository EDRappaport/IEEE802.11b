classdef CCDF< handle
%CCDF   Measure complementary cumulative distribution function
%   H = comm.CCDF creates a complementary cumulative distribution function
%   measurement (CCDF) System object, H. This object measures the
%   probability of a signal's instantaneous power being X dBs above its
%   average power. Use the CCDF object to obtain CCDF curves, and also, peak
%   power, average power, and peak-to-average power ratio (PAPR)
%   measurements.
%
%   H = comm.CCDF(Name,Value) creates a CCDF object, H, with the specified
%   property Name set to the specified Value. You can specify additional
%   name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   [CCDFY,CCDFX] = step(H,X) updates CCDF, average power, and peak power
%   measurements for input X using the CCDF System object, H. It outputs the
%   y-axis, CCDFY, and x-axis, CCDFX, CCDF points. X must be a double
%   precision, MxN matrix, where M is the number of time samples and N is
%   the number of input channels.
%
%   The step method outputs CCDFY as a matrix whose ith column contains
%   updated probability values measured from the ith column of input matrix
%   X. CCDFY contains the y-axis points of the CCDF curves of each channel.
%   The step method outputs CCDFX as a matrix containing, in its ith column,
%   the corresponding updated instantaneous-to-average power ratios for the
%   ith column of input matrix X. CCDFX contains the x-axis points of the
%   CCDF curves of each channel. The object sets the number of rows in CCDFY
%   and CCDFX equal to NumPoints property + 1. The probability values are
%   percentages in the [0 100] interval. When you set the PowerUnits
%   property to 'dBW' or 'dBm', the relative powers are in dB scale. When
%   you set the PowerUnits property to 'Watts', the relative powers are in
%   linear scale. Measurements are updated each time you call the step
%   method until you reset the object. You call the plot method to plot CCDF
%   curves for each channel.
%
%   [CCDFY,CCDFX,AVG] = step(H,X) returns updated average power
%   measurements, AVG, when you set the AveragePowerOutputPort property to
%   true. The step method outputs AVG as a column vector with the ith
%   element corresponding to an updated average power measurement for the
%   signal available in the ith column of input matrix X. You specify the
%   units for AVG in the PowerUnits property.
%
%   [CCDFY,CCDFX,PEAK] = step(H,X) returns updated peak power measurements,
%   PEAK, when you set the PeakPowerOutputPort property to true. The step
%   method outputs PEAK as a column vector with the ith element
%   corresponding to an updated peak power measurement for the signal
%   available in the ith column of input matrix X. You specify the units for
%   PEAK in the PowerUnits property.
%
%   [CCDFY,CCDFX,PAPR] = step(H,X) returns updated peak-to-average power
%   ratio measurements, PAPR, when you set the PAPROutputPort property to
%   true. The step methods outputs PAPR as a column vector with the ith
%   element corresponding to an updated peak-to-average power ratio
%   measurement for the signal available in the ith column of input matrix
%   X. When you set the PowerUnits property to 'dBW' or 'dBm', the method
%   outputs PAPR in a dB scale. When you set the PowerUnits property to
%   'Watts', the method outputs PAPR in a linear scale.
%
%   You can combine optional output arguments when you set their enabling
%   properties. Optional outputs must be listed in the same order as the
%   order of the enabling properties. For example,
%   
%   [CCDFY,CCDFX,AVG,PEAK,PAPR] = step(H,X)
%
%   CCDF methods:
%
%   step                       - Measure CCDF of input (see above)
%   release                    - Allow property value and input
%                                characteristics changes
%   clone                      - Create CCDF measurement object with same
%                                property values
%   isLocked                   - Locked status (logical)
%   reset                      - Reset states of CCDF measurement object
%   plot                       - Plot CCDF curves
%   getPercentileRelativePower - Get percentile relative power
%   getProbability             - Get probability
%
%   CCDF properties:
%
%   NumPoints              - Number of CCDF points
%   MaximumPowerLimit      - Maximum expected input signal power
%   PowerUnits             - Power units
%   AveragePowerOutputPort - Enable average power measurement output
%   PeakPowerOutputPort    - Enable peak power measurement output
%   PAPROutputPort         - Enable PAPR measurement output
%
%   % Example: 
%   %   Obtain CCDF curves for 16-QAM and QPSK signals in AWGN
%
%   hQAM = comm.RectangularQAMModulator(16);       
%   hQPSK = comm.QPSKModulator;
%   hChan = comm.AWGNChannel('NoiseMethod',...
%                        'Signal to noise ratio (SNR)', 'SNR', 15);
%   % Create a CCDF System object and request average power and peak
%   % power measurement outputs
%   hCCDF = comm.CCDF('AveragePowerOutputPort', true, ...
%                        'PeakPowerOutputPort', true);            
%   % Modulate signals
%   sQAM = step(hQAM,randi([0 16-1],20e3,1));
%   sQPSK = step(hQPSK,randi([0 4-1],20e3,1));
%   % Pass signals through an AWGN channel
%   hChan.SignalPower = 10;
%   sQAMNoisy = step(hChan,sQAM);
%   hChan.SignalPower = 1;
%   sQPSKNoisy = step(hChan,sQPSK);
%   % Obtain CCDF measurements
%   [CCDFy,CCDFx,AvgPwr,PeakPwr] = step(hCCDF,[sQAMNoisy sQPSKNoisy]);
%   % plot CCDF curves using the plot method of the CCDF object
%   plot(hCCDF)                                                  
%   legend('16-QAM','QPSK')
%
%   See also comm.ACPR, comm.EVM, comm.MER.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=CCDF
            %CCDF   Measure complementary cumulative distribution function
            %   H = comm.CCDF creates a complementary cumulative distribution function
            %   measurement (CCDF) System object, H. This object measures the
            %   probability of a signal's instantaneous power being X dBs above its
            %   average power. Use the CCDF object to obtain CCDF curves, and also, peak
            %   power, average power, and peak-to-average power ratio (PAPR)
            %   measurements.
            %
            %   H = comm.CCDF(Name,Value) creates a CCDF object, H, with the specified
            %   property Name set to the specified Value. You can specify additional
            %   name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   [CCDFY,CCDFX] = step(H,X) updates CCDF, average power, and peak power
            %   measurements for input X using the CCDF System object, H. It outputs the
            %   y-axis, CCDFY, and x-axis, CCDFX, CCDF points. X must be a double
            %   precision, MxN matrix, where M is the number of time samples and N is
            %   the number of input channels.
            %
            %   The step method outputs CCDFY as a matrix whose ith column contains
            %   updated probability values measured from the ith column of input matrix
            %   X. CCDFY contains the y-axis points of the CCDF curves of each channel.
            %   The step method outputs CCDFX as a matrix containing, in its ith column,
            %   the corresponding updated instantaneous-to-average power ratios for the
            %   ith column of input matrix X. CCDFX contains the x-axis points of the
            %   CCDF curves of each channel. The object sets the number of rows in CCDFY
            %   and CCDFX equal to NumPoints property + 1. The probability values are
            %   percentages in the [0 100] interval. When you set the PowerUnits
            %   property to 'dBW' or 'dBm', the relative powers are in dB scale. When
            %   you set the PowerUnits property to 'Watts', the relative powers are in
            %   linear scale. Measurements are updated each time you call the step
            %   method until you reset the object. You call the plot method to plot CCDF
            %   curves for each channel.
            %
            %   [CCDFY,CCDFX,AVG] = step(H,X) returns updated average power
            %   measurements, AVG, when you set the AveragePowerOutputPort property to
            %   true. The step method outputs AVG as a column vector with the ith
            %   element corresponding to an updated average power measurement for the
            %   signal available in the ith column of input matrix X. You specify the
            %   units for AVG in the PowerUnits property.
            %
            %   [CCDFY,CCDFX,PEAK] = step(H,X) returns updated peak power measurements,
            %   PEAK, when you set the PeakPowerOutputPort property to true. The step
            %   method outputs PEAK as a column vector with the ith element
            %   corresponding to an updated peak power measurement for the signal
            %   available in the ith column of input matrix X. You specify the units for
            %   PEAK in the PowerUnits property.
            %
            %   [CCDFY,CCDFX,PAPR] = step(H,X) returns updated peak-to-average power
            %   ratio measurements, PAPR, when you set the PAPROutputPort property to
            %   true. The step methods outputs PAPR as a column vector with the ith
            %   element corresponding to an updated peak-to-average power ratio
            %   measurement for the signal available in the ith column of input matrix
            %   X. When you set the PowerUnits property to 'dBW' or 'dBm', the method
            %   outputs PAPR in a dB scale. When you set the PowerUnits property to
            %   'Watts', the method outputs PAPR in a linear scale.
            %
            %   You can combine optional output arguments when you set their enabling
            %   properties. Optional outputs must be listed in the same order as the
            %   order of the enabling properties. For example,
            %   
            %   [CCDFY,CCDFX,AVG,PEAK,PAPR] = step(H,X)
            %
            %   CCDF methods:
            %
            %   step                       - Measure CCDF of input (see above)
            %   release                    - Allow property value and input
            %                                characteristics changes
            %   clone                      - Create CCDF measurement object with same
            %                                property values
            %   isLocked                   - Locked status (logical)
            %   reset                      - Reset states of CCDF measurement object
            %   plot                       - Plot CCDF curves
            %   getPercentileRelativePower - Get percentile relative power
            %   getProbability             - Get probability
            %
            %   CCDF properties:
            %
            %   NumPoints              - Number of CCDF points
            %   MaximumPowerLimit      - Maximum expected input signal power
            %   PowerUnits             - Power units
            %   AveragePowerOutputPort - Enable average power measurement output
            %   PeakPowerOutputPort    - Enable peak power measurement output
            %   PAPROutputPort         - Enable PAPR measurement output
            %
            %   % Example: 
            %   %   Obtain CCDF curves for 16-QAM and QPSK signals in AWGN
            %
            %   hQAM = comm.RectangularQAMModulator(16);       
            %   hQPSK = comm.QPSKModulator;
            %   hChan = comm.AWGNChannel('NoiseMethod',...
            %                        'Signal to noise ratio (SNR)', 'SNR', 15);
            %   % Create a CCDF System object and request average power and peak
            %   % power measurement outputs
            %   hCCDF = comm.CCDF('AveragePowerOutputPort', true, ...
            %                        'PeakPowerOutputPort', true);            
            %   % Modulate signals
            %   sQAM = step(hQAM,randi([0 16-1],20e3,1));
            %   sQPSK = step(hQPSK,randi([0 4-1],20e3,1));
            %   % Pass signals through an AWGN channel
            %   hChan.SignalPower = 10;
            %   sQAMNoisy = step(hChan,sQAM);
            %   hChan.SignalPower = 1;
            %   sQPSKNoisy = step(hChan,sQPSK);
            %   % Obtain CCDF measurements
            %   [CCDFy,CCDFx,AvgPwr,PeakPwr] = step(hCCDF,[sQAMNoisy sQPSKNoisy]);
            %   % plot CCDF curves using the plot method of the CCDF object
            %   plot(hCCDF)                                                  
            %   legend('16-QAM','QPSK')
            %
            %   See also comm.ACPR, comm.EVM, comm.MER.
        end

        function getPercentileRelativePower(in) %#ok<MANU>
            %getPercentileRelativePower Get relative power value for a given 
            %                           probability
            %   RPWR = getPercentileRelativePower(H,P) finds the relative power
            %   values, RPWR. The power of the signal of interest is above its
            %   average power by RPWR dB (if PowerUnits equals 'dBW', or 'dBm') or
            %   by a factor of RPWR (in linear scale if PowerUnits equals 'Watts')
            %   with a probability P.
            %
            %   RPWR is a column vector with the ith element corresponding to the
            %   relative power for the ith input channel. Input P can be a double
            %   precision scalar or a vector with a number of elements equal to the
            %   number of input channels. If P is a scalar, then all the relative
            %   powers in RPWR correspond to the same probability value specified in
            %   P. If P is a vector, then the ith element of RPWR corresponds to a
            %   power value that occurs in the ith input channel, with a probability
            %   specified in the ith element of P.
            %
            %   For the ith input channel, this method evaluates the inverse CCDF
            %   curve at probability value P(i).
            %
            %
            %   % Example: 
            %   %   Obtain CCDF curves for a unit variance AWGN signal and a dual-
            %   %   tone signal. The AWGN signal is RPW1 dB above its average power
            %   %   1 percent of the time, and the dual-tone signal is RPW2 dB above
            %   %   its average power 10 percent of the time. This example finds the 
            %   %   values of RPW1 and RPW2.
            %
            %   n = [0:5e3-1].';
            %   s1 = randn(5e3,1);                    % AWGN signal
            %   s2 = sin(0.01*pi*n)+sin(0.03*pi*n);   % dual-tone signal
            %   hCCDF = comm.CCDF;                    % create a CCDF object
            %   step(hCCDF,[s1 s2]);                  % step the CCDF measurements
            %   plot(hCCDF)                           % plot CCDF curves
            %   legend('AWGN','Dual-tone')
            %   RPW = getPercentileRelativePower(hCCDF,[1 10]);
            %   RPW1 = RPW(1)
            %   RPW2 = RPW(2)
            %
            %   See also comm.CCDF.
        end

        function getProbability(in) %#ok<MANU>
            %getProbability Get the probability for a given relative power value
            %   P = getProbability(H,RPWR) finds the probability, P, of the power
            %   level of the signal of interest being RPWR dBs (if PowerUnits equals
            %   'dBW', or 'dBm') or Watts (if PowerUnits equals 'Watts') above its
            %   average power. P is a column vector with the ith element
            %   corresponding to the probability value for the ith input channel.
            %   Input RPWR can be a double precision scalar or a vector with a
            %   number of elements equal to the number of input channels. If RPWR is
            %   a scalar, then all the probability values in P correspond to the
            %   same relative power specified in RPWR. If RPWR is a vector, then the
            %   ith element of P contains a probability value for the ith channel
            %   and for the relative power specified in the ith element of RPWR.
            %
            %   For the ith input channel, this method evaluates the CCDF curve at
            %   relative power value RPWR(i).
            %
            %   % Example: 
            %   %   Obtain CCDF curves for a unit variance AWGN signal and a dual-
            %   %   tone signal. Find the probability that the AWGN signal power is
            %   %   5 dB above its average power and that the dual-tone signal power
            %   %   is 3 dB above its average power.
            %
            %   n = [0:5e3-1].';
            %   s1 = randn(5e3,1);                    % AWGN signal
            %   s2 = sin(0.01*pi*n)+sin(0.03*pi*n);   % dual-tone signal
            %   hCCDF = comm.CCDF;          
            %   step(hCCDF,[s1 s2]);                
            %   plot(hCCDF)                           % plot CCDF curves
            %   legend('AWGN','Dual-tone')
            %   P = getProbability(hCCDF,[5 3])       % get probabilities
            %
            % See also comm.CCDF.
        end

        function plot(in) %#ok<MANU>
            %PLOT   Plot CCDF curves
            %   D = plot(H) plots CCDF measurements in the CCDF System object, H,
            %   and returns the plot handles as an output, D. This method plots as
            %   many curves as the number of input channels. The H input can be
            %   followed by parameter/value pairs to specify additional properties
            %   of the curves. For example, plot(H,'LineWidth',2) will create curves
            %   with line widths of 2 points.
            %
            %   See also comm.CCDF
        end

    end
    methods (Abstract)
    end
    properties
        %AveragePowerOutputPort Enable average power measurement output
        %   When you set this property to true, the step method outputs running
        %   average power measurements. The default is false.
        AveragePowerOutputPort;

        %MaximumPowerLimit Maximum expected input signal power
        %   Specify the maximum expected input signal power limit for each input
        %   channel. Set MaximumPowerLimit to a numeric scalar or row vector with
        %   a length equal to the number of input channels. When you set the
        %   MaximumPowerLimit property to a scalar, the object assumes that the
        %   signals in all input channels have the same expected maximum power.
        %   When you set the MaximumPowerLimit property to a row vector of length
        %   equal to the number of input channels, the object assumes the ith
        %   element of the vector to be the maximum expected power for the signal
        %   at the ith input channel. The default is 50.
        %
        %   At the time you call the step method, the object assumes that the
        %   value in MaximumPowerLimit is in the units that you specified in the
        %   PowerUnits property.
        %
        %   For each input channel, the object obtains CCDF results by integrating
        %   a histogram of instantaneous input signal powers. The object sets the
        %   bins of the histogram so that the last bin collects all power
        %   occurrences that are equal to, or greater than the power that you
        %   specify in the MaximumPowerLimit property. The object will issue a
        %   warning if any input signal exceeds its specified maximum power limit.
        %
        %   You control the size of the histogram bins that the object uses to
        %   estimate CCDF curves (i.e. control the resolution of the curves) with
        %   the NumPoints and MaximumPowerLimit properties.
        MaximumPowerLimit;

        %NumPoints Number of CCDF points
        %   Specify the number of CCDF points that the object calculates. You
        %   control the size of the histogram bins that the object uses to
        %   estimate CCDF curves using the NumPoints and MaximumPowerLimit
        %   properties. This controls the resolution of the curves. The number of
        %   CCDF points must be the same for all the input channels. NumPoints
        %   must be set to a numeric, positive, integer scalar. The default is
        %   1000.
        NumPoints;

        %PAPROutputPort Enable PAPR measurement output
        %   When you set this property to true, the step method outputs running
        %   peak-to-average-power measurements. The default is false.
        PAPROutputPort;

        %PeakPowerOutputPort Enable peak power measurement output
        %   When you set this property to true, the step method outputs running
        %   peak power measurements. The default is false.
        PeakPowerOutputPort;

        %PowerUnits Power units
        %   Specify the power measurement units as one of 'dBm' | 'dBW' | 'Watts'.
        %   The default is 'dBm'. The step method outputs power measurements in
        %   the units specified in the PowerUnits property.
        %
        %   When you set this property to 'dBm' or 'dBW', the step method outputs
        %   relative power values in a dB scale. When you set this property to
        %   'Watts', the step method outputs relative power values in a linear
        %   scale.
        %
        %   When you call the step method, the object assumes that the units of
        %   MaximumPowerLimit are the same as the value you specified in the
        %   PowerUnits property.
        PowerUnits;

    end
end
