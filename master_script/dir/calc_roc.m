% �A���[�g����ROC�Ȑ��\���v�Z����
addpath C:\Users\akihabara\Desktop\work\tamura\toolbox\
addpath C:\Users\akihabara\Desktop\work\tamura\grad_tools\
addpath C:\Users\akihabara\Desktop\work\tamura\my_tools\

%% DTO(���I臒l)�ɂ��ω��_���o
%% ���S����p�����ُ�X�R�A�l�ɑ΂���A���[�g %%
for c = 1:centralitynum()
    % Hirose
    alert = importdata(strcat('./alert/dto/whole/hirose/centrality/', centralityname(c), '/alert.csv'));
    fname = strcat('./roc/dto/whole/hirose/centrality/', centralityname(c), '/roc.csv');
    exportroc(fname, alert);
    % Ide
    alert = importdata(strcat('./alert/dto/whole/ide/centrality/', centralityname(c), '/alert.csv'));
    fname = strcat('./roc/dto/whole/ide/centrality/', centralityname(c), '/roc.csv');
    exportroc(fname, alert);
    % SDML(�e�m�[�h��)
    scores = importdata(strcat('./anomaly_score/node/centrality/', centralityname(c), '/score.csv'));
    dsize = size(scores);
    for node = 1:dsize(2)
        alert = importdata(strcat('./alert/dto/node/centrality/', centralityname(c), '/alert', num2str(node), '.csv'));
        fname = strcat('./roc/dto/node/centrality/', centralityname(c), '/roc', num2str(node), '.csv');
        exportroc(fname, alert);
    end
    % Node OR
    alert = importdata(strcat('./alert/dto/whole/node_or/centrality/', centralityname(c), '/alert.csv'));
    fname = strcat('./roc/dto/whole/node_or/centrality/', centralityname(c), '/roc.csv');
    exportroc(fname, alert);
end

%% �e���S�����̃A���[�g��g�ݍ��킹�� %%
% Hirose
alert = importdata(strcat('./alert/dto/whole2/mix_alert/or/hirose/alert.csv'));
fname = strcat('./roc/dto/whole2/mix_alert/or/hirose/roc.csv');
exportroc(fname, alert);
% Ide
alert = importdata(strcat('./alert/dto/whole2/mix_alert/or/ide/alert.csv'));
fname = strcat('./roc/dto/whole2/mix_alert/or/ide/roc.csv');
exportroc(fname, alert);
% SDML
alert = importdata(strcat('./alert/dto/whole2/mix_alert/or/node_or/alert.csv'));
fname = strcat('./roc/dto/whole2/mix_alert/or/node_or/roc.csv');
exportroc(fname, alert);

%% ���f�[�^��p�����ُ�X�R�A�l %%
% Hirose
alert = importdata('./alert/dto/whole/hirose/alert.csv');
fname = strcat('./roc/dto/whole/hirose/roc.csv');
exportroc(fname, alert);
% Ide
alert = importdata('./alert/dto/whole/ide/alert.csv');
fname = strcat('./roc/dto/whole/ide/roc.csv');
exportroc(fname, alert);