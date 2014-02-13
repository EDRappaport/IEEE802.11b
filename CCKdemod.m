function RxBits = CCKdemod( RxSymbMat )
% function RxBits = CCKdemod( RxSymbMat )
%
% This function takes the output in the form of cckmod's output - a matrix
% where each row is one symbol, 8 chips long, representing 8 (11Mbps)
% or 4 (5.5Mbps).  The function will demodulate the input and output a
% vector of the predicted bits.
%
% ECE408: Wireless Communications
% Implementation of PHY layer of IEEE802.11b
%
% Rappaport, Elliot D
% Weintraub, Elie
% Weintraub, Hillel

% Find possibilities for the last 6 bits for later comparison
% first two bits work differntially, will addr separately
for ii=0:63
    bin = de2bi(ii, 6, 'left-msb');
    symbols(:,ii+1) = cckmod([0 0 bin]);
end
symbolAng = angle(symbols);
symbolAng(symbolAng < -3.141) = symbolAng(symbolAng < -3.141) + 2*pi;
symbolAng(symbolAng > pi+.1) = symbolAng(symbolAng > pi+.1) - 2*pi;

prev_phi1 = 0; %initialize prev to 0

BITS12 = [0 0; 0 1; 1 0; 1 1]; %possibilities for first 2 bits

% go through input matrix, need for loop b/c phi1 is differential
for ii=1:size(RxSymbMat, 1)
    
    %find and isolate phi1
    phi1 = angle(RxSymbMat(ii, 8));
    phi1(phi1 < -3.141) = phi1(phi1 < -3.141) + 2*pi;
    phi1(phi1 > pi+.1) = phi1(phi1 > pi+.1) - 2*pi;
    RxAngles = angle(RxSymbMat(ii,:)) - phi1;
    RxAngles(RxAngles < -3.141) = RxAngles(RxAngles < -3.141) + 2*pi;
    RxAngles(RxAngles > pi+.1) = RxAngles(RxAngles > pi+.1) - 2*pi;

    k(ii) = dsearchn(symbolAng.', RxAngles); %decimal # for last 6 bits +1
    
    % find the differntial phi1, if odd symbol then extra pi shift
    if (mod(ii-1,2))
        adjusted = phi1 - prev_phi1 - pi;
    else
        adjusted = phi1 - prev_phi1;
    end 
    adjusted(adjusted < 3.141) = adjusted(adjusted<3.141) + 2*pi;
    adjusted(adjusted > pi+.1) = adjusted(adjusted > pi+.1) - 2*pi;
    
    %find the phi1 offset and choose relevant
    opt = dsearchn([0 pi/2 pi -pi/2].', adjusted);
    bits12 = BITS12(opt,:);
    add = bi2de([bits12 zeros(1,6)], 'left-msb'); % decimal # for first 2 bits
    
    k(ii) = k(ii)+add-1; %decimal # for 8 bits
    
    prev_phi1 = phi1;
    
end

RxBits = reshape(de2bi(k, 8, 'left-msb').', 1, []).';
%RxBits = k;