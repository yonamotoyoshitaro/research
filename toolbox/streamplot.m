function varargout=streamplot(tt, X, lab, varargin)

[m,n]=size(X);

mm = mean(X);
ss = 2*max(X);
ss(abs(ss)<1e-12)=2*mm(abs(ss)<1e-12);

X = X/spdiag(ss);
X = X + ones(m,1)*(n:-1:1);

h=plot(tt, X, varargin{:});


if ~exist('lab','var') || isempty(lab)
  lab = 1:n;
end

set(gca,'ytick',1:n, 'yticklabel', lab(n:-1:1));



if nargout>0
  varargout{1}=h;
end
