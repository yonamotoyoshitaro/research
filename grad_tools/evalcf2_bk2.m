function [eval]=evalcf2(alm,target,TW)

%�ω��_���m�̕]���l(FAR, benefit)���v�Z
%�ŋߖT�̃A���[�g�̂�benefit�ɉ��Z

cpalm = find(alm);

eval = zeros(1, 2);
benefit = 0;
hitNum = 0;
for i = 1:length(target)
    min = TW;
    for j = 1:length(cpalm)
	l = cpalm(j) - target(i);
        if 0 <= l && l < min
            min = l;
        end
    end
    if min <= TW
        hitNum = hitNum + 1;	
        benefit = benefit + (1-min/TW);
    end
end

benefit = benefit/length(target);


falseNum = 0;
for i = 1:length(cpalm)
    hit = 0;
    for j = 1:length(target)
        l = target(j)-cpalm(i);
        if 0 <= l && l <= TW
            hit = 1;
            break;
        end
    end
    if hit == 0
        falseNum = falseNum + 1;
    end
end
eval(1) = length(cpalm);
eval(2) = falseNum/(length(alm)-(TW+1)*length(target));
eval(3) = benefit;
