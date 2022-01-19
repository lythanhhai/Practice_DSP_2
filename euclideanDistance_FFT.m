function [distance_a, distance_e, distance_i, distance_o, distance_u] = euclideanDistance_FFT(NFFT, dftz_aver, vectorFeatureAver_FFT_a, vectorFeatureAver_FFT_e, vectorFeatureAver_FFT_i, vectorFeatureAver_FFT_o, vectorFeatureAver_FFT_u)
        d_a = 0;
        d_e = 0;
        d_i = 0;
        d_o = 0;
        d_u = 0;
        for j=1:NFFT
            d_a = d_a + power((dftz_aver(j) - vectorFeatureAver_FFT_a(j)), 2);
            d_e = d_e + power((dftz_aver(j) - vectorFeatureAver_FFT_e(j)), 2);
            d_i = d_i + power((dftz_aver(j) - vectorFeatureAver_FFT_i(j)), 2);
            d_o = d_o + power((dftz_aver(j) - vectorFeatureAver_FFT_o(j)), 2);
            d_u = d_u + power((dftz_aver(j) - vectorFeatureAver_FFT_u(j)), 2);
        end
        distance_a = sqrt(d_a);
        distance_e = sqrt(d_e);
        distance_i = sqrt(d_i);
        distance_o = sqrt(d_o);
        distance_u = sqrt(d_u);
end