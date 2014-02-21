function RxBits = CCKdemod( RxSymbStream,bitspersymbol,TotalDelayInBits )
% function RxBits = CCKdemod( RxSymbStream,bitspersymbol,TotalDelayInBits )
%
% This function takes the output in the form of cckmod's output - a vector
% of CCK modulated data.  bitspersymbol will determine whether is
% demodulated assuming 8 bits or 4 bits per symbol.  TotalDelayInBits will
% tell the function how many bits are disposed of as a result of filtering;
% this will affect the alternating pi phase shift.  The function will
% output a vector of the predicted bits.
%
% For a datarate of 5.5Mbps use 4 bitspersymbol.
% For a datarate of 11Mbps use 8 bitspersymbol.
%
% ECE408: Wireless Communications
% Implementation of PHY layer of IEEE802.11b
%
% Rappaport, Elliot D
% Weintraub, Elie
% Weintraub, Hillel


if mod(TotalDelayInBits, bitspersymbol*2) == 0
    norm = 1;
elseif mod(TotalDelayInBits, bitspersymbol) == 0
    norm = 0;
else
    disp('confused');
end

RxSymbMat = reshape(RxSymbStream, 8, []).';
% Find possibilities for the last 6 bits for later comparison
% first two bits work differntially, will addr separately
symbols = zeros(8,2^(bitspersymbol-2));
if (bitspersymbol == 8)
    for ii=0:63
        bin = de2bi(ii, bitspersymbol-2, 'left-msb');
        symbols(:,ii+1) = cckmod([0 0 bin]);
    end
else
    for ii=0:3
        bin = de2bi(ii, bitspersymbol-2, 'left-msb');
        symbols(:,ii+1) = cckmod([0 0 bin], 4);
    end
end
new_symbols = [real(symbols); imag(symbols)];

prev_phi1 = exp(0); %initialize prev to 0

BITS12 = [0 0; 0 1; 1 0; 1 1]; %possibilities for first 2 bits

% go through input matrix, need for loop b/c phi1 is differential
k=zeros(size(RxSymbMat,1),1);
for ii=1:size(RxSymbMat, 1)
    
    %isolate phi1
    Rx_minus_phi1 = RxSymbMat(ii,:)*conj(RxSymbMat(ii, 8));
    new_Rx_minus_phi1 = [real(Rx_minus_phi1) imag(Rx_minus_phi1)];

    k(ii) = dsearchn(new_symbols.', new_Rx_minus_phi1); %decimal # for last 6 bits +1
    
    % find the differntial phi1, if odd symbol then extra pi shift
    if (mod(ii-1,2))
        adjusted = RxSymbMat(ii, 8)*conj(prev_phi1)*exp(-pi*1j*norm);
    else
        adjusted = RxSymbMat(ii, 8)*conj(prev_phi1)*exp(-pi*1j*(~norm));
    end
    
    %find the phi1 offset and choose relevant
    opt = dsearchn([real([1 1j -1  -1j]); imag([1 1j -1  -1j])].', [real(adjusted) imag(adjusted)]);
    bits12 = BITS12(opt,:);
    add = bi2de([bits12 zeros(1,bitspersymbol-2)], 'left-msb'); % decimal # for first 2 bits
    
    k(ii) = k(ii)+add-1; %decimal # for 8 bits
    
    prev_phi1 = RxSymbMat(ii, 8);
    
end

RxBits = reshape(de2bi(k, bitspersymbol, 'left-msb').', 1, []).';