function [ph_mi,ph_serr_mi,amp_mi,amp_serr_mi] = get_MI(pacmat)

% --- get_MI
%      - Produces 2 modulation index arrays (phase and amp direction) from
%        a pac matrix

%Phase MI
ph_mi = mean(pacmat,1);
for iCol = 1:size(pacmat,1)
    ph_serr_mi(iCol) = (std(pacmat(:,iCol)))...
        / sqrt((size(pacmat,1)));
end
%Amplitude MI
amp_mi = mean(pacmat,2);
for iCol = 1:size(pacmat,2)
    amp_serr_mi(iCol) = (std(pacmat(iCol,:)))...
        / sqrt((size(pacmat,2)));
end

end