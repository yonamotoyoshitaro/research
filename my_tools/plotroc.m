function []=plotroc(fname, roc)

% AUCをファイルにエクスポートする
far = roc(:,3);
benefit = roc(:,4);

h=plot(far,benefit,'b');
set(h,'LineWidth',1.0)
grid on;
xlim([0,1.0])
ylim([0,1.0])
xlabel('FAR');
ylabel('benefit');
set(gcf,'PaperPositionMode','auto','PaperSize',[40 40]);
print('-dpng', fname);