% ECE408: Wireless Communications
% Implementation of PHY layer of IEEE802.11b
%
% Rappaport, Elliot D
% Weintraub, Elie
% Weintraub, Hillel
%
% IEEE80211b_ARF_script.m: Implements ARF for IEEE802.11b

clc, clear all, close all;

%% Simulation Parameters
EbNo = 0:2:10;                   % range of noise levels 
NumPackets = 50;                 % number of packets sent
PacketSizeBits = 8192;           % 802.11 packet size
SamplesPerChip = 8;       

%% ARF Parameters
ERR_THRESH = PacketSizeBits/100; % errors above which packet is bad
SUCCESS_THRESH = 5;              % num of good Txs after which we inc. rate

%% Setup
modulateFunctions = {@(x) barkermod(x, 1), @(x) barkermod(x, 2),...
    @(x) cckmod(x, 4), @(x) cckmod(x, 8)};
demodulateFunctions = {@(x) barkerdemod(x, 1), @(x) barkerdemod(x, 2),...
    @(x) CCKdemod(x, 4), @(x) CCKdemod(x, 8)};
BitsPerSymbols = [1, 2, 4, 8];
SpreadingRates = [11, 11, 8, 8];
calcSnr = @(rate,EbNo) EbNo +10*log10(BitsPerSymbols(rate))...
                            -10*log10(SpreadingRates(rate)*SamplesPerChip);

%% Main BER Loop
RateMat=zeros(NumPackets,length(EbNo));
BER = zeros(length(EbNo),1);
for i=1:length(EbNo)
    
    %Initialize Stats
    rate = 1;  TotalBits = 0; ErrorBits = 0;
    numSuccess = 0; numFail = 0; probe = false; 
  
    for packet = 1:NumPackets
        
        RateMat(packet,i)=rate;
        
        snr = calcSnr(rate,EbNo(i));
        
        TxBits = randi([0 1],PacketSizeBits,1);
        TxChips = modulateFunctions{rate}(TxBits);
        [Samples,h,FilterDelayInChips] = TxFilter(TxChips,SamplesPerChip);
        ChannelOutput = awgn(Samples, snr, 'measured'); 
        [RxChips,TotalDelayInBits] = RxFilter(ChannelOutput,h,...
                                  SamplesPerChip,FilterDelayInChips,...
                                BitsPerSymbols(rate),SpreadingRates(rate));
        RxBits = demodulateFunctions{rate}(RxChips);
        
        %Calculate error 
        TotalBits = TotalBits+length(RxBits)-TotalDelayInBits;
        NewErrorBits = sum(TxBits(1:end-TotalDelayInBits)~=...
                        RxBits(TotalDelayInBits+1:end));
        ErrorBits = ErrorBits + NewErrorBits;
        
        %Adjust ARF parameters (numSuccess, numFail, pilot, rate)
        if NewErrorBits > ERR_THRESH   % failure
            numFail = numFail+1;
            if (numFail == 2 || (numFail == 1 && probe)) && rate > 1
                rate = rate-1; numSuccess = 0; numFail = 0;  probe = false;
            end
        else                          % success
            numSuccess = numSuccess+1;
            if numSuccess == SUCCESS_THRESH && rate < 4
                rate = rate+1; numSuccess = 0; numFail = 0; probe = true;
            else
                probe = false; numFail = 0;
            end
        end
        
    end
    BER(i)=ErrorBits/TotalBits;
    
end

%% Plot BER Results
figure('Name','BER vs. EbNo');
semilogy(EbNo,BER,'*-');grid on; 
title('BER for IEEE 802.11b w/ ARF through an AWGN Channel');
xlabel('Eb/No (dB)'); ylabel('Bit Error Rate');
  