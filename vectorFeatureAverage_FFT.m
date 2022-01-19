function [vectorFeatureAver_FFT] = vectorFeatureAverage_FFT(vowelTraining, fileName, startIndex, k, coefficient)
    for i = startIndex:5:91
        %length(vowelTraining)
        [vectorFeature_Before, vectorFeature, dftz] = extractMFCC(vowelTraining(i), fileName(i), k, coefficient);
        if i > 5
            vectorFeatureAver_FFT = vectorFeatureAver_FFT + dftz;
        else
            vectorFeatureAver_FFT = dftz;
        end
        
    end
    
    % k vector đặc trưng
    vectorFeatureAver_FFT = vectorFeatureAver_FFT / 21;
end