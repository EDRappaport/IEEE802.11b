function Y = CCKdemod( RxMat )

for ii=0:63
    bin = de2bi(ii, 6, 'left-msb');
    symbols(:,ii+1) = cckmod([0 0 bin]);
end
symbols(symbols==-pi) = pi;

even_symbols = angle(symbols);
odd_symbols = angle(-symbols);

prev_phi1 = 0;

BITS12 = [0 0; 0 1; 1 0; 1 1];

for ii=1:size(RxMat, 1)
%     if (mod(ii-1, 2))
%         prev_phi1 = angle(-RxMat(ii,8)) - prev_phi1
%     else
%         prev_phi1 = angle(RxMat(ii,8)) - prev_phi1
%     end
    phi1 = angle(RxMat(ii, 8));
    phi1(phi1==-pi) = pi;
    RxAngles = angle(RxMat(ii,:)) - phi1;
    RxAngles(RxAngles < -3.141) = RxAngles(RxAngles < -3.141) + 2*pi;
    RxAngles(RxAngles > pi) = RxAngles(RxAngles > pi) - 2*pi;
%     if (mod(ii-1, 2))
%         k(ii) = dsearchn(odd_symbols.', RxAngles);
%     else
%         k(ii) = dsearchn(even_symbols.', RxAngles);
%     end

    k(ii) = dsearchn(even_symbols.', RxAngles);
    
    if (mod(ii-1,2))
        adjusted = phi1 - prev_phi1 - pi;
    else
        adjusted = phi1 - prev_phi1;
    end
    
    adjusted(adjusted < 3.141) = adjusted(adjusted<3.141) + 2*pi;
    adjusted(adjusted > pi) = adjusted(adjusted > pi) - 2*pi;
    adjusted
    
    opt = dsearchn([0 pi/2 pi -pi/2].', adjusted)
    bits12 = BITS12(opt,:)
    add = bi2de([bits12 zeros(1,6)], 'left-msb')
    
    k(ii) = k(ii)+add;
    
    prev_phi1 = phi1;
end

Y = de2bi(k-1, 8, 'left-msb');
%Y=k-1;