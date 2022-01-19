 %close all;clear;clc
 function [vectorFeature_Before, vectorFeature, dftz_aver] =  extractMFCC(filename, tenFile, k, coefficient)
 
     % input audio
     [x,fs] = audioread(filename);
     %figure('name', tenFile);

     frame_duration = 0.03;
     frame_len = frame_duration * fs;% chiều dài khung 30ms
     overlap_duration = 0.02;
     overlap_len = overlap_duration * fs; 
     L = length(x);

     % phân khung cho tín hiệu
     numberFrames = floor((L - frame_len) / overlap_len + 1);% số khung được chia
     P = zeros(numberFrames, frame_len);
     for i = 1:numberFrames
         startIndex = (i - 1) * overlap_len + 1;
         endIndex = (i - 1) * overlap_len + frame_len + 1;
         if endIndex <= L
            for j = 1:frame_len
                P(i, j) = x(startIndex + j - 1);
            end 
         else 
            for j = 1:(L - startIndex)
                P(i, j) = x(startIndex + j - 1);
            end 
            for j = (L - startIndex + 1):frame_len
                P(i, j) = 0;
            end
         end
     end

    % phân tách nguyên âm, khoảng lặng
    findMagnitude = STE(P, numberFrames, frame_len, overlap_duration);
    
    findMagnitude(1);
    findMagnitude(length(findMagnitude));
    
    % chia nguyên âm thành 3 vùng và lấy vùng ở giữa cho các khung ổn định
    segmentAver = floor((findMagnitude(length(findMagnitude)) - findMagnitude(1)) / overlap_duration / 3);
    magniLeft =  round(findMagnitude(1) / overlap_duration + segmentAver);
    magniRight =  round(findMagnitude(length(findMagnitude)) / overlap_duration - segmentAver);
    
    % tính mfcc
    c = v_melcepst(x, fs, 'M', coefficient, floor(3*log(fs)), round(0.03*fs), round(0.03*fs/1.5), 0, 0.5);
    length(c);
    c;
    c(139);
    
    % trích vector đặc trưng của từng khung
    col = 1;
    for i=1:length(c)
        if i >= magniLeft && i <= magniRight 
            for j=1:coefficient
                vectorFrame(col, j) = c(i, j);
            end
            col = col + 1;
        end
    end
    vectorFrame;
    
    % tính vector đặc trưng trung bình các khung ổn định
    for i=1:length(vectorFrame(:, 1))
        if i > 1
            vectorFeature_Before = vectorFeature_Before + vectorFrame(i, :);
        else 
            vectorFeature_Before = vectorFrame(i, :);
        end
    end
    vectorFeature_Before = vectorFeature_Before / (magniRight - magniLeft + 1);
    
 
    % Tạo ma trận centroid

    X0 = zeros(k, 1);
    if k <= (magniRight - magniLeft + 1)
       for i=1:k
           X0(i) = vectorFrame(i, 6);
       end
    else
       for i=1:(magniRight - magniLeft + 1)
           X0(i) = vectorFrame(i, 6);
       end
    end

    % tìm k vector trung bình
    [vectorFeature] = v_kmeans(vectorFrame, k);  
    vectorFeature;
    
    for i=(magniLeft):(magniRight)
        dftz = vectorFFT(P(i, :), 1024);
        if i == (magniLeft)
            dftz_aver = dftz;
        else
            dftz_aver = dftz_aver + dftz;
        end
    end
    dftz_aver = dftz_aver / (magniRight - magniLeft + 1);
    
    %{
    % khung thời gian tín hiệu
    time = (1/fs)*length(x);
    t = linspace(0, time, length(x));
    
    % vẽ tín hiệu
    subplot(2,1,1);
    plot(t, x);
    xlabel('time(sec)');
    ylabel('magnitude');
    title(['Speech signal ', tenFile]);
    
    time1 = (1/fs)*length(c);
    t1 = linspace(0, time1, length(c));
    subplot(2,1,2);
    plot(t1, c);
    %}
 end