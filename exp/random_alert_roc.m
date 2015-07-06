% ランダムにアラートを上げた場合のAUCの期待値を計算する
addpath C:\Users\akihabara\Desktop\work\tamura\my_tools\

fid = fopen(char('random_alert_roc.csv'),'w');
for i = 0:100
    far = 0.01 * i;
    probs = zeros(1, 20);
    prob = far;
    s = 0;
    for t = 1:20
        benefit = 1-(t-1)/20;
        %s = s + benefit * prob;
        s = s + benefit * far;
        probs(t) = prob;
        %prob  = (1-sum(probs)) * (2*far-far*far);
        prob  = (1-sum(probs)) * far;
    end
    fprintf(fid,'%f, %f, %f, %f\r\n', far,sum(probs) , far, s/10.5);
end
fclose(fid);

roc = importdata(strcat('random_alert_roc.csv'));
fname = strcat('random_alert_auc.csv');
exportauc(fname, roc);
fname2 = strcat('random_alert_roc.png');
plotroc(fname2, roc);