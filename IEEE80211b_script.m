% ECE408: Wireless Communications
% Implementation of PHY layer of IEEE802.11b
%
% Rappaport, Elliot D
% Weintraub, Elie
% Weintraub, Hillel
%
% IEEE80211b_script.m: Implements IEEE802.11b either at a fixed data rate
% or employing ARF.

clc,clear all,close all;

%% Mode Selection 
ARF = input('Do you want to use ARF (true, false): ');
if ~ARF
    RATE = input('What data rate do you want to use (1, 2, 5.5, 11): ');
    switch RATE
        case 1,   RATE = 1;
        case 2,   RATE = 2;
        case 5.5, RATE = 3;
        case 11,  RATE = 4;
    end
end
DISPLAY = input('Do you want status info displayed (true, false): ');

tic
%% Simulation Parameters
EbNo = 0:2:10;                   % range of noise levels 
NumPackets = 50;                 % number of packets sent
PacketSizeBits = 8192;           % 802.11 packet size
SamplesPerChip = 8;       

%% ARF Parameters
if ARF
    ERR_THRESH = PacketSizeBits/100; % num errors above which packet is bad
    SUCCESS_THRESH = 5;              % num of good pkts needed to transition
    RateMat=zeros(NumPackets,length(EbNo));
end

%% Setup
modulateFunctions = {@(x) barkermod(x, 1), @(x) barkermod(x, 2),...
    @(x) cckmod(x, 4), @(x) cckmod(x, 8)};
demodulateFunctions = {@(x,y) barkerdemod(x, 1), @(x,y) barkerdemod(x, 2),...
    @(x,y) CCKdemod(x, 4, y), @(x,y) CCKdemod(x, 8, y)};
BitsPerSymbols = [1, 2, 4, 8];
SpreadingRates = [11, 11, 8, 8];
DataRates = [1, 2, 5.5, 11];
calcSnr = @(rate,EbNo) EbNo +10*log10(BitsPerSymbols(rate))...
                            -10*log10(SpreadingRates(rate)*SamplesPerChip);
                        
%% Main BER Loop
BER = zeros(length(EbNo),1);
for i=1:length(EbNo)
    
    %Initialize Stats
    if ARF
        rate = 1;  TotalBits = 0; ErrorBits = 0;
        numSuccess = 0; numFail = 0; probe = false; 
    else
        rate = RATE;  TotalBits = 0; ErrorBits = 0;
    end
    
    for packet = 1:NumPackets
       
        if DISPLAY
            disp(['Simulating EbNo = ' num2str(EbNo(i)),...
                  ' Packet ' num2str(packet) '...']);
        end
        
        snr = calcSnr(rate,EbNo(i));
        
        TxBits = randi([0 1],PacketSizeBits,1);
        TxChips = modulateFunctions{rate}(TxBits);
        [Samples,h,FilterDelayInChips] = TxFilter(TxChips,SamplesPerChip);
        ChannelOutput = awgn(Samples, snr, 'measured'); 
        [RxChips,TotalDelayInBits] = RxFilter(ChannelOutput,h,...
                                  SamplesPerChip,FilterDelayInChips,...
                                BitsPerSymbols(rate),SpreadingRates(rate));
        RxBits = demodulateFunctions{rate}(RxChips, TotalDelayInBits);
        
        %Calculate error 
        TotalBits = TotalBits+length(RxBits)-TotalDelayInBits;
        NewErrorBits = sum(TxBits(1:end-TotalDelayInBits)~=...
                        RxBits(TotalDelayInBits+1:end));
        ErrorBits = ErrorBits + NewErrorBits;
        
        %Adjust ARF parameters (numSuccess, numFail, pilot, rate)
        if ARF
            RateMat(packet,i)=rate;
             
            if NewErrorBits > ERR_THRESH   % failure
                numFail = numFail+1;
                if (numFail == 2 || (numFail == 1 && probe)) && rate > 1
                    rate = rate-1; numSuccess = 0; numFail = 0;probe = false;
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
        
    end
    BER(i)=ErrorBits/TotalBits;
    
end

%% Plot BER Results
if ARF
    title_str = 'BER for IEEE 802.11b w/ ARF through an AWGN Channel';
else
    title_str = ['BER for IEEE 802.11b ' num2str(DataRates(rate))...
                 'Mbps through an AWGN Channel']; 
end

figure('Name','BER vs. EbNo');
semilogy(EbNo,BER,'*-');grid on; 
title(title_str); xlabel('Eb/No (dB)'); ylabel('Bit Error Rate');

%% Plot ARF transitions
if ARF
    figure('Name','ARF Transitions');
    for i=1:length(EbNo)
        subplot(3,2,i);plot(1:NumPackets,RateMat(:,i));
        legend(['EbNo = ' num2str(EbNo(i))]);title('ARF Transitions');
        xlabel('Packet Number');ylabel('Data Rate');
        set(gca,'yTickLabel',{'1Mbps','2Mbps','5.5Mbps','11Mbps'});
    end
end
toc
