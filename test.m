function [idx, c, sumd, sa, K] = test(Data, k)
    sa=[];
    K=[];
    for i=1:k
        [idx c sumd]=kmeans(Data,i);
        sa=[sa sum(sumd)];
        K=[K k];
    end
end