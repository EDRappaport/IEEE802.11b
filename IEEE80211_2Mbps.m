% Elie Weintraub 
% ECE408 - Wireless Comms.
% Standard Simulation: IEEE 802.11b through an AWGN Channel
% 2/12/14

clc,clear all,close all

%% Define Simulation Parameters
EbNo = 0:10;                  % range of noise levels 
NumPackets = 10;              % number of packets sent
PacketSizeBits = 8192;        % 802.11 packet size 

%% Define System Parameters for 1 Mbps Data Rate
%Alphabet
M = 4;                                          
BitsPerSymbol=log2(M);
%Spreading Sequence
Barker = [1 -1  1  1 -1  1  1  1 -1 -1 -1]';    % Barker Spreading Sequence
SpreadingRate = 11;

%Upsampling Rate
SamplesPerChip = 8;

%Simulation SNR Values
SNR = EbNo +10*log10(BitsPerSymbol)-10*log10(SpreadingRate*SamplesPerChip);

%Define DBPSK Modulator and Demodulator Objects
DQPSK_Mod = comm.DQPSKModulator('BitInput',true,'SymbolMapping','Binary');    
DQPSK_Demod = comm.DQPSKDemodulator('BitOutput',true,'SymbolMapping','Binary');   

%Define Root-Raised Cosine Filter Properties and Tx and Rx Filter Objects
FilterSpanInSymbols = 5;
RolloffFactor = 0.7;
TxFilter = comm.RaisedCosineTransmitFilter(...
               'RolloffFactor',RolloffFactor, ...
               'OutputSamplesPerSymbol',SamplesPerChip, ...
               'FilterSpanInSymbols',FilterSpanInSymbols);
RxFilter = comm.RaisedCosineReceiveFilter(...
              'RolloffFactor',RolloffFactor, ...
              'InputSamplesPerSymbol',SamplesPerChip, ...
              'FilterSpanInSymbols',FilterSpanInSymbols, ...
              'DecimationFactor', SamplesPerChip);

%Calculate Delay Caused  by Filtering
FilterDelayInSamples = 2*order(TxFilter)/2;
FilterDelayInChips = FilterDelayInSamples/SamplesPerChip;
AlignmentChipDelay = SpreadingRate - mod(FilterDelayInChips,SpreadingRate);
TotalDelayInChips = FilterDelayInChips + AlignmentChipDelay;
TotalDelayInSymbols = TotalDelayInChips/SpreadingRate;
TotalDelayInBits = TotalDelayInSymbols*BitsPerSymbol; 

%% Main BER loop (Run simulation for each noise level)
BER = zeros(length(SNR),1);
for i=1:length(SNR)
    %Initialize System State
    TotalBits = 0;
    ErrorBits = 0;
    RxDelayedChipsBuffer = zeros(AlignmentChipDelay,1);
    TxDelayedBitsBuffer = zeros(TotalDelayInBits,1);
    
    for packet=1:NumPackets
        %%%%%%%%%%%%%%%%Transmitter%%%%%%%%%%%%%%%%%
        %Generate packet containing random data
        TxBits = randi([0 1],PacketSizeBits,1);
         
        %Modulate data
        TxSymbols = step(DQPSK_Mod,TxBits);
        
        %Spread symbols with Barker code (upsampling by spreading rate)
        TxChips = reshape(Barker*TxSymbols',[],1);
        
        %Pulse-shape transmitted symbols (upsampling by samples per chip)
        TxSamplesFiltered = step(TxFilter,TxChips);
        
        %Transmit through AWGN channel
        ChannelOutput =  awgn(TxSamplesFiltered,SNR(i),'measured');
        
        %%%%%%%%%%%%%%%%%%Receiver%%%%%%%%%%%%%%%%%%%
        %Filter received signal with pulse-shaping filter
        RxChips = step(RxFilter,ChannelOutput);
        
        %Align signal with 11 chip boundary by adding chip delay
        RxAlignedChips = [RxDelayedChipsBuffer;...
                          RxChips(1:end-AlignmentChipDelay)];
        
        %Store delayed chips
        RxDelayedChipsBuffer = RxChips(end-AlignmentChipDelay+1:end);
        
        %Despread by multiplying by Barker sequence
        RxAlignedChips = reshape(RxAlignedChips,...
                               SpreadingRate,PacketSizeBits/BitsPerSymbol);
        RxSymbols = reshape(Barker'*RxAlignedChips,[],1)/SpreadingRate;
        
        %Demodulate Data
        RxBits = step(DQPSK_Demod,RxSymbols);
        
        %%%%%%%%%%%%BER Calculation%%%%%%%%%%%%%%%%%%%
        %Add delay to TxBits to align with RxBits. Store bits from Tx tail 
        TxBitsDelayed = [TxDelayedBitsBuffer; 
                         TxBits(1:end-TotalDelayInBits)];
        TxDelayedBitsBuffer = TxBits(end-TotalDelayInBits+1:end);
        
        if packet==1 %Ignore transient on first transmission
            TotalBits = length(RxBits)-TotalDelayInBits;
            ErrorBits = sum(TxBitsDelayed(TotalDelayInBits+1:end)~=...
                            RxBits(TotalDelayInBits+1:end));
        else
            TotalBits = TotalBits+length(RxBits);
            ErrorBits = ErrorBits+sum(TxBitsDelayed~=RxBits);
        end
    end
    
    BER(i)=ErrorBits/TotalBits;
    
end
%% Plot BER Results
figure('Name','BER vs. EbNo');
semilogy(EbNo,BER,'*-');grid on; 
title('BER for IEEE 802.11b 2Mbps through an AWGN Channel');
xlabel('Eb/No (dB)'); ylabel('Bit Error Rate');




