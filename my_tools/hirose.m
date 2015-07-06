function [score]=hirose(data)

% �e�m�[�h�̒��S�����瑊�ݑ��֍s��𐶐����A���̌ŗL�l����ُ�X�R�A���v�Z����v���O����
% Hirose, Yamanishi��̎�@
% cf. Network Anomaly Detection based on Eigen Equation Compression

%% �ُ�X�R�A��̌v�Z %%
%{
    t-1���_�ł̑��ϗʐ��K���z�̖��x�֐��𐄒肵�A
    t���_�̌ŗL�l�x�N�g���ُ̈�X�R�A���At-1���_�Ő��肳�ꂽ���x�֐�����̃��A�x�������ĕ\��
%}
W = 5;                              % ���֍s��쐬���̃E�B���h�E��
M = 3;                              % ��ʂ����܂ł̌ŗL�l�𗘗p���邩
LAMDA = [];                         % �ŗL�l�x�N�g��(���m����ׂ��x�N�g��)�����n�񏇂ɕ��ׂ�����
score = zeros(1, length(data));     % �X�R�A��
m = -1;                             % (t-1���_�ɂ�����)����
c = -1;                             % (t-1���_�ɂ�����)�����U�s��
dsize = size(data);
N = dsize(2);
for i = 1:(length(data)-W)
    % ���֍s��̐���
    f = i;
    t = i+W;
    T = data(f:t, 1:N);
    A = abs(corrcoef(T));
    % NAN �� 0�ϊ�
    for a = 1:N
        for b = 1:N
            if(isnan(A(a,b)))
                A(a,b) = 0;
            end
        end
    end
    % ���m�̌ŗL�l�𗘗p�����x�N�g��
    lamda =  eigs(A,M).';
    % �ُ�X�R�A�̌v�Z
    if f > 2  && det(c) ~= 0
        p = exp((-1/2)*(lamda-m)*(c\(lamda-m).'))/((2*pi)^(M/2)*det(c)^(1/2));
        if p > 0 && p ~= Inf && p~= -Inf
            score(t) = real(-log(p));
        else
            score(t) = 0;
        end
    end
    % �p�����[�^���X�V
    LAMDA = vertcat(LAMDA,lamda);
    m = mean(LAMDA);
    c = cov(LAMDA);
end