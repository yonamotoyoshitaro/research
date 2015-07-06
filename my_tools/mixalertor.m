function [mix_alert]=mixalertor(total_alert)

% ÉAÉâÅ[ÉgÇÃORåãçáÇÇ∆ÇÈ

msize = size(total_alert);
mix_alert = zeros(msize(2), msize(3));

for i = 1:msize(1)
    for j = 1:msize(2)
        for k = 1:msize(3)
            if total_alert(i, j, k) == 1
                mix_alert(j, k) = 1;
            end
        end
    end    
end