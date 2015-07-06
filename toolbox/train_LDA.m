function C=train_LDA(Xtr,Ytr,lambda,opt)

[W,D]=FDA(Xtr,Ytr,lambda);

m1=mean(Xtr(Ytr>0,:))';
m2=mean(Xtr(Ytr<0,:))';

C=struct('w',W,...
         'bias',-W'*(m1+m2)/2);
