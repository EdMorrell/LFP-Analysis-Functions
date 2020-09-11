function [diff_mat,pac_fhand] = PAC_Diff(Pac1,Pac2,plot,name)

% --- Finds the difference between 2 PAC matrices (ie pos 1 vs pos 2) and
%     produces a difference matrix and phase and amp MI differences
%     
%     Inputs:
%            - Pac1: First PAC matrix
%            - Pac2: Second PAC matrix (difference is calculated as change
%                    from pac1 to pac2 ie pac2 - pac1)
%            - plot: 1 = plot
%                    0 = no plot (default = 0)
%            - Name: Name of the plot
%     Outputs:
%             - diff_mat: Difference Matrix

if nargin < 3
    plot = 0;
end
if nargin < 4
    name = '';
end

%Params
amp_fv = 1:10:201;
ph_fv = 1:1:21;

%Finds PAC differences
diff_mat = Pac2 - Pac1;

%Plots PAC differences
if plot == 1
	[pac_fhand] = PAC_Plot(ph_fv,amp_fv,diff_mat,name);
end

end

