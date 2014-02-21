function [ symbols ] = cckmod( data,bitspersymbol )
% function [ symbols ] = cckmod( data,bitspersymbol )
%
% This function takes in a bitstream (data) and a bitspersymbol and
% complementary code keying modulates  the data. The function will output
% symbols which will be a vector of the modulated data.
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

%default bitspersymbol=8
if nargin<2, bitspersymbol=8; end

%add zeros to make length(data) a multiple of bitspersymbol and reshape
%data into rows of 
if mod(length(data),bitspersymbol)~=0
    data=[data(:); zeros(bitspersymbol-mod(length(data),bitspersymbol),1)];
end
data=reshape(data,bitspersymbol,[])';

%formula for the cck symbol
c = @(phi1,phi2,phi3,phi4) [exp(1j*(phi1+phi2+phi3+phi4)) exp(1j*(phi1+phi3+phi4))... 
                            exp(1j*(phi1+phi2+phi4)) -exp(1j*(phi1+phi4)) ...
                            exp(1j*(phi1+phi2+phi3)) exp(1j*(phi1+phi3))...
                            -exp(1j*(phi1+phi2)) exp(1j*(phi1))];
                        
if bitspersymbol==4 %5.5Mbps datarate
    [phi2, phi3, phi4]=getcckphases5_5(data(:,3:4));
   
else               %11Mbps datarate
    [phi2, phi3, phi4]=getcckphases11(data(:,3:end));
end
    
phi1=getdqpskphase(data(:,1:2));
    
symbols=c(phi1,phi2,phi3,phi4);
symbols = symbols.'; symbols = symbols(:);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [phi2, phi3, phi4]=getcckphases5_5(data)
%get the phases for 5.5Mbps cck symbols
%data is a matrix with rows of bit pairs (d2 d3)

phi2=data(:,1)*pi+pi/2;
phi3=zeros(size(phi2));
phi4=data(:,2)*pi;

end

function [phi2, phi3, phi4]=getcckphases11(data)
%get the phases for 11Mbps cck symbols
%data is a matrix with rows of bit pairs (d2d3 d4d5 d6d7)

phi2 = getqpskphase(data(:,1:2));
phi3 = getqpskphase(data(:,3:4));
phi4 = getqpskphase(data(:,5:6));

end

function [phi] = getqpskphase(data)
%get the qpsk phases

phi=zeros(size(data,1),1);
for ii=1:length(phi)
    switch char(data(ii,:))
        case char([0 0])
            phi(ii)=0;
        case char([0 1])
            phi(ii)=pi/2;
        case char([1 0])
            phi(ii)=pi;
        case char([1 1])
            phi(ii)=-pi/2;
    end
end
end

function [phi]= getdqpskphase(data)
%data is a matrix with rows of bit pairs (d0 d1)

pioffsets=0:pi:(size(data,1)-1)*pi;
phi=cumsum(getqpskphase(data)+pioffsets');

end
