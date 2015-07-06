function [fp,bp]=randpermfb(n)

fp=randperm(n);
[ss,bp]=sort(fp);
