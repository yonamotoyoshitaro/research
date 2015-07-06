function [X,Y]=load_spambase()
S=importdata('/data/uci/spambase/spambase.data');
X=S(:,1:end-1);
Y=S(:,end)*2-1;
