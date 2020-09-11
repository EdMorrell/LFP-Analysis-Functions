function [pac_fhand] = PAC_Plot(ph_fv,amp_fv,pacmat,pacmat_name,clims)

% --- PAC_Plot
%       - Function plots a PAC matrix

if nargin < 4
    pacmat_name = '';
end

%% Pacmat Plotter
%figure;
pac_fhand = imagesc(ph_fv,amp_fv,pacmat);
title(pacmat_name)
set(gca,'YDir','normal')
colorbar
colormap jet
if nargin < 5
    caxis = get(gca,'clim');
else
    caxis = clims;
end
pac_fhand = gca;
pac_fhand.FontName = 'Arial';
%pac_fhand.FontWeight = 'bold';
pac_fhand.Box = 'off';
%pac_fhand.LineWidth = 1.5;
%pac_fhand.TickDir = 'out';

end