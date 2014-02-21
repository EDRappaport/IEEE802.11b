function [ chips ] = barkermod( data,bitspersymbol )
% function [ symbols ] = barkermod( data,BitsPerSymbol )
%
% This function takes in a bitstream (data) and a bitspersymbol and
% DPSK modulates the data sreading with a Barker code. The output is 
% the corresponding stream of chips which will be a vector of length 
% data/BitsPerSymbol*SpreadingRate.
%
% For a datarate of 1Mbps use 1 bitspersymbol (DBPSK).
% For a datarate of 2Mbps use 2 bitspersymbol (DQPSK).
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
Barker = [1 -1  1  1 -1  1  1  1 -1 -1 -1]';  % Barker Spreading Sequence

%Define Modulator Object 
switch bitspersymbol
    case 1    % 1 Mbps data rate (DBPSK Modulation)
        DPSK_Mod = comm.DBPSKModulator;   
    case 2    % 2 Mbps data rate (DQPSK Modulation)
        DPSK_Mod = comm.DQPSKModulator(0,'BitInput',true,'SymbolMapping','Binary');    
end

%Modulate data
symbols = step(DPSK_Mod,data);

%Spread symbols with Barker code (upsampling by spreading rate)
chips = reshape(Barker*symbols.',[],1);