N = 1e5;
SNR = 0:2:10;

for ind=1:length(SNR)
    snr = SNR(ind);
    
    Tx_bits = rand(N,1)>.5;
    Tx_symbols = cckmod(Tx_bits);
    
    Rx_symbols = awgn(Tx_symbols, snr);
    Rx_bits = CCKdemod(Rx_symbols);    
    
    BER(ind) = sum(Rx_bits~=Tx_bits)/length(Tx_bits);
end

semilogy(SNR, BER, '*-'); grid;
title('802.11b 11Mbps DQPSK BER');
ylabel('BER')
xlabel('SNR');