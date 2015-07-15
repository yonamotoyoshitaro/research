% �����_���ɃA���[�g���グ���ꍇ��AUC�̊��Ғl���v�Z����
% �Б��O�p�^
addpath C:\Users\akihabara\Desktop\work\tamura\my_tools\

auc_total = [];
for T = 1:50
    fid = fopen(char('random_alert_roc_limit.csv'),'w');
    for i = 0:50
        far = 0.001 * i;
        probs = zeros(1, T);
        prob = far;
        s = 0;
        for t = 1:T
            benefit = 1-(t-1)/T;
            s = s + benefit * prob;
            probs(t) = prob;
            prob  = (1-sum(probs)) * far;
        end
        fprintf(fid,'%f, %f, %f, %f\r\n', far,sum(probs) , far, s);
    end
    fclose(fid);

    roc = importdata(strcat('random_alert_roc_limit.csv'));
    fname = strcat('random_alert_auc_limit.csv');
    exportauc(fname, roc);
    fname2 = strcat('random_alert_roc_limit.png');
    plotroc(fname2, roc);
    auc = importdata(strcat('random_alert_auc_limit.csv'));
    auc_total = vertcat(auc_total, auc);
end
fname3 = 'random_alert_auc_limit.csv';
exportscore2(fname3, auc_total);