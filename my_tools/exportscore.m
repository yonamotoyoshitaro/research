function []=exportscore(fname, score)

% �ُ�X�R�A����t�@�C���ɃG�N�X�|�[�g����

fid = fopen(char(fname),'w');
for i = 1:length(score)
    fprintf(fid,'%f\r\n',score(i));
end
fclose(fid);
