% applyClassifier - applies a classifier
%
% Example (LDA):
%  out = applyClassifier('LDA', C, Xte);
%
% Copyright (C) Ryota Tomioka 2010
function out=applyClassifier(model, C, X)

[func, param]=getfuncparam(model,'apply_');

if ischar(func) && ~exist(func)
  out = apply_linear(C, X);
else
  out=feval(func, C, X);
end


