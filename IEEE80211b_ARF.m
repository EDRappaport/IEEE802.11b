clear all;

%% Simulation Parameters
EbNo = 0:10;                    % range of noise levels 
NumPackets = 1e3;               % number of packets sent
PacketSizeBits = 8192;          % 802.11 packet size

modulateFunctions = {@(x) barker1mod(x), @(x) barker2mod(x),...
    @(x) cckmod(x, 4), @(x) cckmod(x, 8)};
demodulateFunctions = {@(x) barker1demod(x), @(x) barker2demod(x),...
    @(x) CCKdemod(x, 4), @(x) CCKdemod(x, 8)};

%% Main BER Loop
for i=1:length(EbNo)
    
    %Initialize Stats
    numSuccess = 0;
    numFail = 0;
    rate = 1;
    for packet = 1:NumPackets
        
        if numSuccess > 9
            rate = min(rate+1,4);
        elseif numFail > 1
            rate = max(rate-1, 0);
        end
        
        snr = calcSnr{rate}(EbNo(i));
        
        TxBits = randi([0 1],PacketSizeBits,1);
        TxChips = modulateFunctions{rate}(TxBits);
        TxSamplesFiltered = ourTxFilter(TxChips);
        ChannelOutput = awgn(TxSamplesFiltered, snr, 'measured');
        RxChips = ourRxFilter(ChannelOutput);
        
        RxBits = demodulateFunctions{rate}();
        
        %claculate error and adjust numSuccess and numFail
        
    end
end
        
        