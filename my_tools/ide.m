function [score]=ide(data)

% �e�m�[�h�̒��S�����瑊�ݑ��֍s��𐶐����A���̌ŗL�l�x�N�g������ُ�X�R�A���v�Z����v���O����
% Ide��̎�@

%% �ُ�X�R�A��̌v�Z %%
W1 = 5;         % ���n��f�[�^���瑊�֍s������鎞�ԕ�
W2 = 6;         % �����x�N�g���񂩂�ߋ��������̂ڂ鎞�ԕ�
score = zeros(1, length(data));   % �X�R�A��
U = [];                                 % �����x�N�g��(�ő�ŗL�l�ɑΉ�����ő�ŗL�x�N�g��(�m�����P))�s��(Node�~W2)
r = -1;                                  % t-1���_�ɂ������L�����x�N�g���̓����x�N�g�� 
dsize = size(data);
N = dsize(2);
for i = 1:length(data)-W1
    % ���֍s��̍쐬
    f = i;
    t = i+W1;
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
    % �����x�N�g���v�Z
    [uu, s] =  eig(A);
    u = uu(:,1);
    U = horzcat(u,U);
    % �X�R�A�̌v�Z
    if(i >= W2)
        if r ~= -1
            score(t) = 1 - abs(r'*u);
        end
        % �_���̎�11-13�ɂ�����r(t)���v�Z
        [vv, cc] =  eig(U'*U);
        v = vv(:,W2); % �E�ɍő�ŗL�l�Ƃ���ɑΉ�����x�N�g��������
        c = 1/sqrt(cc(W2,W2));
        r = c*U*v;
        U(:,W2) = []; % �P�ԌÂ������x�N�g���͒ǂ��o��
    end
end