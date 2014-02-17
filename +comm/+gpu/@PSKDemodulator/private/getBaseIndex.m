function baseIndex = getBaseIndex(inputSignal, bitsPerSymbol, addPerBit, phaseCorrection, modulationOrder)
% Copyright 2011 The MathWorks, Inc.
    derotatedSignal = inputSignal*phaseCorrection;
    theta = atan2(imag(derotatedSignal), real(derotatedSignal)); %angle(derotatedSignal);
    baseIndex = round(theta*modulationOrder/pi - 0.5);
    baseIndex = bitsPerSymbol * ...
        (baseIndex + 2*modulationOrder*(baseIndex < 0)) + addPerBit;
end