%clear; clc; clf;
function [dftz] = vectorFFT(frame, pointFFT)

    z = zeros(1, length(frame));
    w = hamming(length(frame));
    
    for i=1:length(frame)
      z(i) = frame(i)*w(i);
    end

    dftz = abs(fft(z, pointFFT));
    dftz = dftz(1:(length(dftz) / 2));
    %dftz = 10*log10(dftz);
end
