function []=exportauc(fname, roc)

% AUCをファイルにエクスポートする
fid = fopen(char(fname),'w');
far = roc(:,3);
benefit = roc(:,4);
if max(benefit) == 0
    fprintf(fid,'0, 0, 0, 0, 0, 0, 0\r\n');
end
mean_benefit = mean(benefit);
prev_far = -1;
prev_benefit = 0;
s = 0;
for j = 1:length(far)
    if prev_far <= far(j)
        if prev_far >= 0
            s = s +  (prev_benefit+benefit(j))/2 * (far(j)-prev_far);
        end
        prev_far = far(j);
        prev_benefit = benefit(j);
    end
end
L = far(length(far)) - far(1);
if L == 0
    s = mean_benefit;
end
% 面積(平均値), FAR平均値, FAR標準偏差, FAR分散, Benefit平均値, Benefit標準偏差, Benefit分散
fprintf(fid,'%f, %f, %f, %f, %f, %f, %f\r\n',s, mean(far), std(far), var(far), mean(benefit), std(benefit), var(benefit));
fclose(fid);