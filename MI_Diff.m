function [diff_MI,diff_SEM] = MI_Diff(MI1,MI2,SEM1,SEM2)

% --- Finds the difference between 2 MI arrays (ie pos 1 vs pos 2) and
%     produces a difference array (also does the same for SEM arrays if
%     provided)
%     
%     Inputs:
%            - MI1: First MI array
%            - MI2: Second MI array (difference is calculated as change
%                    from MI1 to MI2. ie MI2 - MI1)
%            - SEM1
%            - SEM2
%     Outputs:
%             - diff_MI & diff_SEM: Difference Array

if nargin == 4
    diff_SEM = SEM2 - SEM1;
elseif nargin > 2 && nargin < 4
    error('Must provide 2 SEM arrays to compute SEM difference')
end

%Finds MI differences
diff_MI = MI2 - MI1;

end