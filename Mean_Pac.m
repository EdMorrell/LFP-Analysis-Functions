function [mean_pac] = Mean_Pac(pacs)

% --- Mean_Pac
%        - Find the mean of all PAC matrices in a cell array
%     
%     Inputs:
%            - pacs: cell array(n x 1) of pac matrices
%     Outputs:
%            - mean_pac: Mean PAC matrix

sum_pac = zeros(20,20);
for iCell = 1:size(pacs,1)
    
    sum_pac = sum_pac + pacs{iCell,1};
    
end

mean_pac = sum_pac / size(pacs,1);

end