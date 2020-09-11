function [mean_MI,SEM_MI] = mean_MI(MI_array)

% --- Compute mean and SEM MI
%      - MI array must array be in form (n x MI_band)

    mean_MI = nanmean(MI_array);
    SEM_MI = std(MI_array,1)/ sqrt(size(MI_array,1));
    
end