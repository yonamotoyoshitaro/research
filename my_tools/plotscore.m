function []=plotscore(fname, score)

% 異常スコア列をプロットする

nlabel=length(score);
xx=linspace(0,length(score)-1,length(score));

ymin = min(score);
ymax = max(score);
if ymin == ymax
    ymin = ymin - 1;
    ymax = ymax + 1;
end

h=plot(xx,score,'b');
set(h,'LineWidth', 1.0)
grid on;
xlim([xx(1),xx(end)])
ylim([ymin, ymax])
set(gca,'XTick',nlabel)
xlabel('Time');
set(gca,'YTickLabel',{})
ylabel('Score');
hold off;
set(gcf,'PaperPositionMode','auto','PaperSize',[40 40]);
print('-dpng', fname);