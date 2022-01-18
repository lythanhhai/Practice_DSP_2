function [vectorFeatureAver] = vectorFeatureAverage(vowelTraining, fileName, startIndex, k, coefficient)
    % nguyên âm huấn luyện
    for i = startIndex:5:length(vowelTraining)
        [vectorFeature_Before, vectorFeature] = extractMFCC(vowelTraining(i), fileName(i), k, coefficient);
        if i > 5
            vectorFeatureAver = vectorFeatureAver + vectorFeature;
        else
            vectorFeatureAver = vectorFeature;
        end
        
    end
    
    % k vector đặc trưng
    vectorFeatureAver = vectorFeatureAver / 21;

end