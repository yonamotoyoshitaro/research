function []=exportscore2(fname, score)

% 各ノードの異常スコア列をファイルにエクスポートする

fid = fopen(char(fname),'w');
dsize = size(score);
for i = 1:dsize(1)
    for j = 1:dsize(2)
        % 数値
        if isnan(score(i,j))
            fprintf(fid,'0');
        else
            fprintf(fid,'%f',score(i,j));
        end
        % 区切り
        if j ~= dsize(2)
            fprintf(fid,',');
        end
    end
    fprintf(fid,'\r\n');
end
fclose(fid);
