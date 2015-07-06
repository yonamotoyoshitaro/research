% select_model - selects model parameters
%
% Usage:
% [lmd,loss] = select_model(model, X, Y, lambdas, varargin)
%
function [lmd,loss] = select_model(model, X, Y, lambdas, varargin)

opt=propertylist2struct(varargin{:});
opt=set_defaults(opt, 'folds', [1 10], 'findmin', 'medin', 'loss', '0_1','display',1);


if opt.display>0
if isnumeric(lambdas)
  fprintf('Inner xvalidation for lambdas=[%g ... %g]\n',min(lambdas),max(lambdas));
else
  fprintf('Inner xvalidation for lambdas={%s ... %s}\n',printvec(lambdas{1}),printvec(lambdas{end}));
end
end  

[Lm,Ls,Itr,Ite,output,memo]...
    =xvalidation(X, Y, model, lambdas, opt.folds,opt,'display',opt.display-1);


loss = cell2mat(getfieldarray(memo,'loss'));


[gfun, gpar]=getfuncparam(opt.findmin, 'findmin_');
if isempty(gpar)
  ix=feval(gfun, Lm);
else
  ix=feval(gfun, Lm, gpar{:});
end

lmd = lambdas(ix);

if opt.display>0
  if isnumeric(lmd)
    fprintf('Selected lmd=%g (loss=%g)!\n', lmd, Lm(ix));
  else
    fprintf('Selected lmd=%s (loss=%g)!\n', printvec(lmd{:}), Lm(ix));
  end
end



