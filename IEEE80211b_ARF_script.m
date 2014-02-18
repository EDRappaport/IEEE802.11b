clear all;

%% Simulation Parameters
EbNo = 0:10               % range of noise levels 
NumPackets = 1e3;         % number of packets sent
PacketSizeBits = 8192;    % 802.11 packet size
THRESHOLD = 0             % errorbits above which packet is considered bad 
modulateFunctions = {@(x) barkermod(x, 1), @(x) barkermod(x, 2),...
    @(x) cckmod(x, 4), @(x) cckmod(x, 8)};
demodulateFunctions = {@(x) barkerdemod(x, 1), @(x) barkerdemod(x, 2),...
    @(x) CCKdemod(x, 4), @(x) CCKdemod(x, 8)};

%% Main BER Loop
BER = zeros(length(EbNo),1)
for i=1:length(EbNo)
    
    %Initialize Stats
    numSuccess = 0; numFail = 0; probe = false; rate = 1;
    TotalBits = 0; ErrorBits = 0;
    for packet = 1:NumPackets
        
        snr = calcSnr{rate}(EbNo(i));
        
        TxBits = randi([0 1],PacketSizeBits,1);
        TxChips = modulateFunctions{rate}(TxBits);
        [Samples,h,SamplesPerChip,FilterDelayInChips] = TxFilter(TxChips);
        ChannelOutput = awgn(Samples, snr, 'measured'); 
        [Rxchips,TotalDelayInBits] = RxFilter(ChannelOutput,h,...
            SamplesPerChip,FilterDelayInChips,BitsPerSymbol,SpreadingRate);
        RxBits = demodulateFunctions{rate}(RxChips);
        
        %claculate error and adjust numSuccess and numFail
        TotalBits = TotalBits+length(RxBits)-TotalDelayInBits;
        NewErrorBits = sum(TxBits(1:end-TotalDelayInBits)~=...
                        RxBits(TotalDelayInBits+1:end));
        ErrorBits = ErrorBits + NewErrorBits;
        if NewErrorBits > THRESHOLD          % failure
            numFail = numFail+1;
            if (numFail == 2 || (numFail == 1 && probe)) && rate > 1
                rate = rate-1; numSuccess = 0; numFail = 0;  probe = false;
            end
        else                        % success
            numSuccess = numSuccess+1;
            if numSuccess == 10 && rate < 4
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
  