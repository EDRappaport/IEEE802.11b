function [chips,TotalDelayInBits] = RxFilter(samples,h,SamplesPerChip,...
                            BitsPerSymbol,SpreadingRate,FilterDelayInChips)
% function [chips,TotalDelayInBits] = RxFilter(samples,h,SamplesPerChip,...
%                           BitsPerSymbol,SpreadingRate,FilterDelayInChips)
%
% This function takes in a sample stream (samples) and the impulse response
% of the corresponding TxFilter and outputs the result of  a raised
% root cosine filter. After filtering the input sample stream is 
% downsampled by SamplesPerChip. The output is also aligned with a symbol
% boundary and the TotalDelayInBits is returned.
%
% For datarates of 1 Mbps and 2 Mbps use SpreadingRate = 11.
% For datarates of 5.5 Mbps  and 11 Mbps use SpreadingRate = 8.
%
% ECE408: Wireless Communications
% Implementation of PHY layer of IEEE802.11b
%
% Rappaport, Elliot D
% Weintraub, Elie
% Weintraub, Hillel

%Filter Samples
samples = filter(h,1,samples);

%Downsample
chips = samples(1:SamplesPerChip:end);

%Calculate alignment delay and total delay in bits (the transient)
AlignmentChipDelay = SpreadingRate - mod(FilterDelayInChips,SpreadingRate);
TotalDelayInChips = FilterDelayInChips + AlignmentChipDelay;
TotalDelayInSymbols = TotalDelayInChips/SpreadingRate;
TotalDelayInBits = TotalDelayInSymbols*BitsPerSymbol; 

%Align chips with symbol boundary
chips=[zeros(AlignmentChipDelay,1);chips];
