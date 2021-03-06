function [alm]=alarm1(scores,N,rho,lam,r)

% ***æ©è?***
% åçããã??é¸æ?è©³ç´°ã¯é«æ©ã?åè«åç§)ã«ããã¹ã³ã¢ã??ã¿ã«
% å¯¾ãã¦ã¢ã©ã¼ã?ä¸ããé¢æ°??
% ***å¥å?**
% scores:ã¹ã³ã¢ã??ã¿å?æ¨ªãã¯ãã«)
% N:ã»ã«ã®æ°
% rho:é¾å¤ãã©ã¡ã¼ã¿
% lam:æ¨å®ãã©ã¡ã¼ã¿
% r:å¿å´ä¿æ°

% ***åºå?**
% alm:ã¢ã©ã¼ã??ãªã³ã»ãªããè¡¨ãã?ã¯ãã«?å?åãã¼ã¿åã¨é·ãã?åã??
% è³ªåç­ããã?tosh.914@gmail.comã«ã©ã???
M = length(scores); % datasize
min = nanmin(scores);
%min = nanmean(scores)-3*nanstd(scores);
%max = nanmax(scores);
max = nanmean(scores)+3*nanstd(scores);
alm = zeros(1,M); % alarm on or off
q1 = zeros(1,N); % 
q1 = q1 + 1.0/N; % uniform distribution
w = (max-min)/(N-2); % cell width
b = zeros(1,N-1); % left border of the cells
% calculate left border of the cells
for i=1:N-2
    b(i) = min+w*(i-1);
end
b(N-1) = max;

for i=1:M
    q = (q1+lam)/(sum(q1)+N*lam);
    % find and calc threshold
    l=1;
    for j=1:N
        if sum(q(1:j)) < 1.0-rho
            l=j+1;
        end
    end
    if l == 1
        l = 2;
    end
    eta = b(l-1);
    % decide alarm or not
    if scores(i) >= eta
        alm(i) = 1;
    end
    % find the cell which the score drop in
    h = 1;
    for j=1:N-1
        if scores(i) >= b(j)
            h = j+1;
        end
    end
    % recalc probability of the cells
    q1 = (1.0-r)*q1;
    q1(h) = q1(h) + r;
end