function []=exportroc(fname, alert)

% ROC曲線表をファイルにエクスポートする

as = size(alert);
fid = fopen(char(fname),'w');
fprintf(fid,'0,0,0,0\r\n');
for p = 1:as(2)
    a = evalcf2(alert(:,p), roctarget(), roctw());
    fprintf(fid,'%f,%d,%d,%d\r\n',p, a(1), a(2), a(3));
end
fclose(fid);