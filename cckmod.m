function [ symbols ] = cckmod( data,bitspersymbol )
%function [ symbols ] = cckmod( data,bitspersymbol )
%This function takes in a bitstream (data) and a bitspersymbol and
%complementary code keying modulates  the data. symbols will be a matrix of
%symbols where each row  is a length 8 complex vector corresponding to a 
%single symbol

%default bitspersymbol=8
if nargin<2, bitspersymbol=8; end

%add zeros to make length(data) a multiple of bitspersymbol and reshape
%data into rows of 
data=[data(:); zeros(bitspersymbol-mod(length(data),bitspersymbol),1)];
reshape(data,[],bitspersymbol);
end

