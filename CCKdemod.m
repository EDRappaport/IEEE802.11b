function Y = CCKdemod(RxMat)

for ii=0:63
    bin = de2bi(ii, 6, 'left-msb');
    symbols(:,ii+1) = cckmod([0 0 bin]);
end

even_symbols = angle(symbols);
odd_symbols = angle(-symbols);

prev_phi1 = 0;

for ii=1:size(RxMat, 1)
    if (mod(ii-1, 2))
        prev_phi1 = angle(-RxMat(ii,8)) - prev_phi1;
    else
        prev_phi1 = angle(RxMat(ii,8)) - prev_phi1;
    end
    RxAngles = angle(RxMat(ii,:)) - prev_phi1;
    k = dsearchn(even_symbols.', RxAngles)   
    
end

Y=symbols;