% getfuncparam - split function name and parameters
%
% Example:
%  [func, param]=getfuncparam({func, 'param1', 'value1'})
% 
% Example (with prefix):
%  [func, param]=getfuncparam({'svm','kernel','rbf'},'train_');
%
% Copyright (C) Ryota Tomioka 2010
function [func,param]=getfuncparam(model, prefix)

if ~exist('prefix','var')
  prefix='';
end


if iscell(model)
  funcname=model{1};
  if length(model)>1 && isnumeric(model{2})
    param=model(2:end);
  else
    param=propertylist2struct(model{2:end});
  end
else
  funcname=model;
  param=[];
end

if ischar(funcname)
  func=[prefix funcname];
else
  func=funcname;
end

