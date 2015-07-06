function [Lm, Ls, Itr, Ite, output, memo]=xvalidation(X, Y, model, lambda, nTrials, varargin)

opt=propertylist2struct(varargin{:});
opt=set_defaults(opt, 'preproc', '',...
                      'sample', 'balanced',...
                      'selectsample', @(X,ix)X(ix,:),...
                      'selectsample_te', [],...
                      'selectsample_y', @(Y,ix)Y(ix),...
                      'selectsample_yte',[],...
                      'loss', '0_1',...
                      'warmstart', 1,...
                      'display',1);

if isempty(opt.selectsample_te)
  opt.selectsample_te=@(X,ixte,ixtr)opt.selectsample(X,ixte);
end

if isempty(opt.selectsample_yte)
  opt.selectsample_yte=opt.selectsample_y;
end


[Itr,Ite]=feval(['sample_' opt.sample], nTrials, Y);

if isequal(unique(Y),[0 1])
  Y=2*Y-1;
end

if size(Y,1)<size(Y,2)
  Y=Y';
end

if isempty(lambda)
  nlmd=1;
else
  nlmd=length(lambda);
end



[fnc_pp,param_pp]=getfuncparam(opt.preproc,'preproc_');

loss=zeros([size(Itr), nlmd]);

memo=repmat(struct('C',[],'out',[],'loss',[]),...
            [size(Itr),nlmd]);

output=zeros(size(Itr,1),length(Y),nlmd);

for ii=1:size(Itr,1)
  for jj=1:size(Itr,2)
    Xtr=opt.selectsample(X,Itr{ii,jj});
    Ytr=opt.selectsample_y(Y,Itr{ii,jj});

    if ~isempty(opt.preproc)
      [Ftr,optproc]=feval(fnc_pp, Xtr, param_pp);
    else
      Ftr=Xtr;
    end
    
    Xte=opt.selectsample_te(X,Ite{ii,jj},Itr{ii,jj});
    Yte=opt.selectsample_yte(Y,Ite{ii,jj});

    if ~isempty(opt.preproc)
      optproc.Xtr=Xtr;
      Xte=feval(fnc_pp,Xte,optproc);
    end

    C=[];
    for kk=1:nlmd

      if opt.warmstart
        C0=C;
      else
        C0=[];
      end
      if isempty(lambda)
        if opt.display>0
          fprintf('Fold:%d of Split:%d ', jj, ii);
        end
        C=trainClassifier(model, Ftr, Ytr, [], 'initial_solution', C0);
      else
        if iscell(lambda)
          lmd = lambda{kk};
        else
          lmd = lambda(kk);
        end
        if opt.display>0
          fprintf('Fold:%d of Split:%d lambda=%s ', jj, ii, printvec(lmd));
        end
        C=trainClassifier(model, Ftr, Ytr, lmd, 'initial_solution', C0);
      end
      out=applyClassifier(model, C, Xte);
      lkk = feval(['loss_' opt.loss],Yte, out);
      loss(ii,jj,kk)= lkk;
      memo(ii,jj,kk)=struct('C',C,...
                            'out',out,...
                            'loss',lkk);
      output(ii,Ite{ii,jj},kk)=out;
      
      if opt.display>0
        fprintf('loss=%g\n',lkk);
      end
    end
  end
end

Lm=mean(loss,2);
Ls=shiftdim(std(Lm,[],1));
Lm=shiftdim(mean(Lm,1));


