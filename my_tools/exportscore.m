function []=exportscore(fname, score)

% 異常スコア列をファイルにエクスポートする

fid = fopen(char(fname),'w');
for i = 1:length(score)
    fprintf(fid,'%f\r\n',score(i));
end
fclose(fid);
