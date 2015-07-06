function [X,Y]=load_musk()

S=importdata('/data/uci/musk/clean1.data');
X=S.data(:,1:end-1);
Y=S.data(:,end)*2-1;
