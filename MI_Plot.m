function [mi_fhand] = MI_Plot(MI_array1,MI_serr_array1,MI_array2,...
    MI_serr_array2,x,name,colour1,colour2)

% --- MI_Plot
%        - This function plots 2 modulation index arrays (can be phase or
%          amplitude) with errorbars

if nargin < 6
    name = '';
end
if nargin < 7
    colour1 = 'k';
end
if nargin < 8
    colour2 = 'c';
end

figure; 
mi_fhand = errorbar(x,MI_array1,MI_serr_array1, '-s',...
    'MarkerFaceColor',colour1,...
    'LineWidth', 1.5,...
    'Color', colour1);
hold on
mi_fhand = errorbar(x,MI_array2,MI_serr_array2, '-s',...
    'MarkerFaceColor',colour2,...
    'LineWidth', 1.5,...
    'Color', colour2);
xlim([0 max(x)])
title(name)
mi_fhand = gca;
mi_fhand.FontName = 'Arial';
mi_fhand.FontWeight = 'bold';
mi_fhand.Box = 'off';
mi_fhand.LineWidth = 1.5;
mi_fhand.TickDir = 'out';

end