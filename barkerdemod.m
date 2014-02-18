function [ data ] = barkerdemod( chips,bitspersymbol )
% function [ data ] = barkerdemod( chips,bitspersymbol )
%
% This function takes in a chipstream (chips) and a bitspersymbol and
% DPSK demodulates, first desreading with a Barker code. The output is 
% the corresponding stream of bits which will be a vector of length 
% chips*BitsPerSymbol/SpreadingRate.
%
% For a datarate of 1Mbps use 1 bitpersymbol (DBPSK).
% For a datarate of 2Mbps use 2 bitpersymbol (DQPSK).
%
% ECE408: Wireless Communications
% Implementation of PHY layer of IEEE802.11b
%
% Rappaport, Elliot D
% Weintraub, Elie
% Weintraub, Hillel

%default bitspersymbol=1
if nargin<2, bitspersymbol=1; end

%Spreading Sequence
Barker = [1 -1  1  1 -1  1  1  1 -1 -1 -1];   % Barker Spreading Sequence
SpreadingRate = 11;                           % Chips per symbol

%Define Deodulator Object 
switch bitspersymbol
    case 1    % 1 Mbps data rate (DBPSK Modulation)
        DPSK_Demod = comm.DBPSKDemodulator;   
    case 2    % 2 Mbps data rate (DQPSK Modulation)
        DPSK_Demod = comm.DQPSKDemodulator(0,'BitOutput',true,'SymbolMapping','Binary');    
end

%Despread by multiplying by Barker sequence
chips = reshape(chips,SpreadingRate,[]);
symbols = reshape(Barker*chips,[],1)/SpreadingRate;

%Demodulate Data
data = step(DPSK_Demod,symbols);