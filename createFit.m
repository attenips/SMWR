function pd1 = createFit(x)
%CREATEFIT    Create plot of datasets and fits
%   PD1 = CREATEFIT(X)
%   Creates a plot, similar to the plot in the main distribution fitter
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with distributionFitter
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  1
%
%   See also FITDIST.

% This function was automatically generated on 01-Mar-2024 02:00:47

% Output fitted probablility distribution: PD1

% Data from dataset "x data":
%    Y = x

% Force all inputs to be column vectors
x = x(:);

% Prepare figure
clf;
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "x data"
[CdfY,CdfX] = ecdf(x,'Function','cdf');  % compute empirical function
hLine = stairs(CdfX,CdfY,'Color',[0.333333 0 0.666667],'LineStyle','-', 'LineWidth',1);
xlabel('Data');
ylabel('Cumulative probability')
LegHandles(end+1) = hLine;
LegText{end+1} = 'x data';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "Dist Gumbel"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('extreme value',[ 1746.751673279, 599.2865782844])
pd1 = fitdist(x, 'extreme value');
[YPlot,YLower,YUpper] = cdf(pd1,XGrid,0.05);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
if ~isempty(YLower)
    hBounds = plot([XGrid(:); NaN; XGrid(:)], [YLower(:); NaN; YUpper(:)],'Color',[1 0 0],...
        'LineStyle',':', 'LineWidth',1,...
        'Marker','none');
end
LegHandles(end+1) = hLine;
LegText{end+1} = 'Dist Gumbel';
LegHandles(end+1) = hBounds;
LegText{end+1} = '95% confidence bounds';

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northwest');
set(hLegend,'Interpreter','none');
