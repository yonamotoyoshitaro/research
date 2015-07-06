function [score]=hirose_origin(data)

% �e�m�[�h�̒��S�����瑊�ݑ��֍s��𐶐����A���̌ŗL�l����ُ�X�R�A���v�Z����v���O����
% Hirose, Yamanishi��̎�@
% cf. Network Anomaly Detection based on Eigen Equation Compression

%% �ُ�X�R�A��̌v�Z %%
%{
    t-1���_�ł̑��ϗʐ��K���z�̖��x�֐��𐄒肵�A
    t���_�̌ŗL�l�x�N�g���ُ̈�X�R�A���At-1���_�Ő��肳�ꂽ���x�֐�����̃��A�x�������ĕ\��
%}
M = 3;                                      % ��ʂ����܂ł̌ŗL�l�𗘗p���邩
LAMDA = [];                                 % �ŗL�l�x�N�g��(���m����ׂ��x�N�g��)�����n�񏇂ɕ��ׂ�����
dsize = size(data);                         % �f�[�^�T�C�Y
score = zeros(1, length(data)/dsize(2));    % �X�R�A��
m = -1;                                     % (t-1���_�ɂ�����)����
c = -1;                                     % (t-1���_�ɂ�����)�����U�s��
for i = 1:length(data)/dsize(2)
    % ���֍s��̐���
    A = data(1+dsize(2)*(i-1):dsize(2)*i,:);
    % ���m�̌ŗL�l�𗘗p�����x�N�g��
    lamda =  eigs(A,M).';
    % �ُ�X�R�A�̌v�Z
    if i > 2  && det(c) ~= 0
        p = exp((-1/2)*(lamda-m)*(c\(lamda-m).'))/((2*pi)^(M/2)*det(c)^(1/2));
        if p > 0
            score(i) = real(-log(p));
            if score(i) == Inf || score(i) == -Inf
                score(i) = 0;
            end
        else
            score(i) = 0;
        end
    end
    % �p�����[�^���X�V
    LAMDA = vertcat(LAMDA,lamda);
    m = mean(LAMDA);
    c = cov(LAMDA);
end