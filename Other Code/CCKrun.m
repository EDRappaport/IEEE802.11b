% CCKrun
%
% This script will simulate the IEEE802.11b High Rate DSSS approach using
% complimentary code keying (CCK).
%
% ECE408: Wireless Communications
% Implementation of PHY layer of IEEE802.11b
%
% Rappaport, Elliot D
% Weintraub, Elie
% Weintraub, Hillel
clear all;

N = 1e4;
SNR = 0:2:20;
bitspersymbol = 4;

Tx_bits = double(rand(N,1)>.5);
for ind=1:length(SNR)
    snr = SNR(ind);
    
    Tx_symbols = cckmod(Tx_bits, bitspersymbol);
    
    Rx_symbols = awgn(Tx_symbols, snr, 'measured');
    Rx_bits = CCKdemod(Rx_symbols, bitspersymbol, 16);    
    
    BER(ind) = sum(Rx_bits~=Tx_bits)/length(Tx_bits);
end

figure; semilogy(SNR, BER, '*-'); grid;
title('802.11b 11Mbps DQPSK BER');
ylabel('BER');
xlabel('SNR');

BER