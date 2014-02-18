function [samples,h,SamplesPerChip,FilterDelayInChips] = TxFilter(chips,...
                            SamplesPerChip,FilterSpanInChips,RollOffFactor)
% function [samples,h,SamplesPerChip,FilterDelayInChips]=TxFilter(chips,...
%                           SamplesPerChip,FilterSpanInChips,RollOffFactor)
%
% This function takes in a chipstream (chips) as well as optional filter
% parameters and outputs the result of  a raised root cosine filter.
% Before filtering the input chipstream is upsampled by SamplesPerChip.
% In addition to the output of the filter, the filter impusle rsponse,
% the SamplesPerChip, and the FilterDelayInChips are returned.
%
% ECE408: Wireless Communications
% Implementation of PHY layer of IEEE802.11b
%
% Rappaport, Elliot D
% Weintraub, Elie
% Weintraub, Hillel

%defaults: RollOffFacor=0.7, SamplesPerChip=8, FilterSpanInChips=5
if nargin<4, RollOffFactor=0.7; end
if nargin<3, FilterSpanInChips=5; end
if nargin<2, SamplesPerChip=8; end

%Calculate Filter Order and Impulse Response
FilterOrder = FilterSpanInChips*SamplesPerChip;
Fc = 7e6;              % cutoff frequency
Fs = 88e6;             % sampling frequency
delay = FilterOrder/2; % to make filter causal
window = kaiser(FilterOrder+1,1);
h=firrcos(FilterOrder,Fc,RollOffFactor,Fs,'rolloff','sqrt',delay,window);

%Upsample chips by SamplesPerChip 
samples = zeros(length(chips)*SamplesPerChip,1);
samples(1:SamplesPerChip:end) = chips;
samples = samples/sqrt(SamplesPerChip); % Normalize power due to upsampling 

%Filter samples
samples = filter(h,1,samples);

%Calculate Filtering Delay
FilterDelayInSamples = 2*FilterOrder/2;
FilterDelayInChips = FilterDelayInSamples/SamplesPerChip;
