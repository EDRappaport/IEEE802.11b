function Y = CCKdemod(RxMat)

for ii=0:63
    bin = de2bi(ii, 6, 'left-msb');
    symbols(:,ii+1) = cckmod([0 0 bin]);
end

even_symbols = symbols;
odd_symbols = -symbols;

orig_phi1 = 0;

Y=symbols;