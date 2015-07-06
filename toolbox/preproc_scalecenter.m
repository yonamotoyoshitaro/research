function [X,opt]=preproc_scalecenter(X,opt)


L=size(X,1);

if ~exist('opt','var') || ~isfield(opt,'mm') || ~isfield(opt,'ss')
  opt.mm=mean(X);
  opt.ss=std(X);
end

X=(X-ones(sum(L),1)*opt.mm)/spdiag(opt.ss);

