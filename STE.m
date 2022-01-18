function [findMagnitude] = STE(P, numberFrames, frame_len, overlap_duration) 
    % tính STE cho từng khung
    ste = zeros(1, numberFrames);
    for l=1:numberFrames
        sumSTE=0;
        for k=1:frame_len
            sumSTE = sumSTE + power(P(l, k), 2);
        end
        ste(1, l) = sumSTE;
    end

    % chuẩn hóa ste
    ste = ste./max(ste(1, :));

    % xác định ngưỡng
    th_ste = 0.01;

    % xác định nguyên âm
    index = 1;
    for i=1:numberFrames-1
        % vowel
        if(ste(1, i) > th_ste)
            if ((ste(1, i + 1) < th_ste))
                findMagnitude(index) = overlap_duration * (i);
                index = index + 1;
            end
        % silence 
        else 
            if (ste(1, i + 1) > th_ste)
                findMagnitude(index) = overlap_duration * (i + 1);
                index = index + 1;
            end
        end
    end
end