function []=exportalert(fname, score)

% �A���[�g���t�@�C���ɃG�N�X�|�[�g����
% DTO�̓��I臒l�p�����[�^��0.01--1.00�͈̔͂ŕω��������Ƃ��̃A���[�g��csv�ɏo��
% �e�񂪂���臒l�ɑ΂���A���[�g�Y�����A�e�s�����ԂɊY��

N=20;           % ���I�������l�X�V�p�����[�^�F�Z����
lambda=0.01;    % ���I�������l�X�V�p�����[�^�F�w�K�p�����[�^
r=0.05;         % �ω��_���o�p�����[�^�F�Y�p�W��

%TODO: �S���͂�0�������ꍇ�̓A���[�g��S�������Ȃ�
% �����Ƃ��ׂĂɑ΂��ăA���[�g���オ���Ă��܂��B�B
if isempty(find(score, 1))
    alert = zeros(100, length(score));
else
    alert = [];
    for i = 1:100
        p = 0.01 * i;
        alert = vertcat(alert, alarm1(score, N, p, lambda, r));  
    end
end
exportscore2(fname, alert.');