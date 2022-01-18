function [distance_a, distance_e, distance_i, distance_o, distance_u] = euclideanDistance(k, coefficient, vectorFeature_Before_Test, vectorFeatureAver_a, vectorFeatureAver_e, vectorFeatureAver_i, vectorFeatureAver_o, vectorFeatureAver_u)
    for i=1:k
        d_a = 0;
        d_e = 0;
        d_i = 0;
        d_o = 0;
        d_u = 0;
        for j=1:coefficient
            d_a = d_a + power((vectorFeature_Before_Test(j) - vectorFeatureAver_a(i, j)), 2);
            d_e = d_e + power((vectorFeature_Before_Test(j) - vectorFeatureAver_e(i, j)), 2);
            d_i = d_i + power((vectorFeature_Before_Test(j) - vectorFeatureAver_i(i, j)), 2);
            d_o = d_o + power((vectorFeature_Before_Test(j) - vectorFeatureAver_o(i, j)), 2);
            d_u = d_u + power((vectorFeature_Before_Test(j) - vectorFeatureAver_u(i, j)), 2);
        end
        distance_a(i) = sqrt(d_a);
        distance_e(i) = sqrt(d_e);
        distance_i(i) = sqrt(d_i);
        distance_o(i) = sqrt(d_o);
        distance_u(i) = sqrt(d_u);
    end
    
end