function []=exportscore2(fname, score)

% �e�m�[�h�ُ̈�X�R�A����t�@�C���ɃG�N�X�|�[�g����

fid = fopen(char(fname),'w');
dsize = size(score);
for i = 1:dsize(1)
    for j = 1:dsize(2)
        % ���l
        if isnan(score(i,j))
            fprintf(fid,'0');
        else
            fprintf(fid,'%f',score(i,j));
        end
        % ��؂�
        if j ~= dsize(2)
            fprintf(fid,',');
        end
    end
    fprintf(fid,'\r\n');
end
fclose(fid);
