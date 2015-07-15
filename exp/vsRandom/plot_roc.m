% 2‚Â‚ÌROC‹Èü‚ğ•`‰æ
addpath C:\Users\akihabara\Desktop\work\tamura\my_tools\

roc = importdata(strcat('random_alert_roc.csv'));
roc2 = importdata(strcat('roc.csv'));
fname2 = strcat('vs_random.png');
plotroc2(fname2, roc, roc2);