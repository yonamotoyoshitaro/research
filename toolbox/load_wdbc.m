function [X,Y]=load_wdbc()

S=importdata('/data/uci/breast-cancer-wisconsin/wdbc.data');
X=S.data;
Y=strcmp(S.textdata(:,2),'M')*2-1;

