function [eval]=evalcf(alm,target,TW)

%変化点検知の評価値(FAR, benefit)を計算

cpalm = detect(alm);

eval = zeros(1, 2);
benefit = 0;
falseNum = 0;
for i = 1:length(cpalm)
    hit = 0;
    for j = 1:length(target)
        if abs(cpalm(i)-target(j)) < TW
            benefit = benefit + (1-abs(cpalm(i)-target(j))/TW); 
            hit = 1;
            break;
        end
    end
    if hit == 0
        falseNum = falseNum + 1;
    end
end
eval(1) = length(cpalm);
eval(2) = falseNum/length(alm);
eval(3) = benefit;
