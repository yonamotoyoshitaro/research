% trainClassifier - trains a classifier
%
% Example (LDA):
%  C=trainClassifier('LDA',Xtr,Ytr);
%
% Example (RDA):
%  C=trainClassifier('LDA',Xtr,Ytr, lambda);
%
% Copyright (C) Ryota Tomioka 2010
function C=trainClassifier(model, X, Y, lambda, varargin)

[func,param]=getfuncparam(model,'train_');

try
  for jj=1:length(varargin)/2
    param=setfield(param, varargin{2*jj-1}, varargin{2*jj});
  end
catch
  errstr=sprintf('Invalid param-value list [%s]', lasterr);
  error(errstr);
end

if ~exist('lambda','var') || isempty(lambda)
  C=feval(func, X, Y, param);
else
  C=feval(func, X, Y, lambda, param);
end
