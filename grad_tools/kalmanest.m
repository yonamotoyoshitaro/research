% Usage:
%  [T,X,V]=kalman(T, Y, dt, vi, vo)
%   T: time
%   Y: output
%   dt: discretization window size
%   vi: internal noise variance
%   vo: observation noise variance
function [T,X,V]=kalmanest(T, Y, dt, vi, vo)

[tt, I, J]=unique(floor(T/dt));

m=length(tt);

T=(tt(1):tt(end))';
X=zeros(length(T),1);
V=zeros(length(T),1);


tt=tt-tt(1)+1;
xx=0;
vv=vi;
I0=0;
for ii=1:m
  if ii>1
    X(tt(ii-1)+1:tt(ii)-1)=xx*ones(tt(ii)-tt(ii-1)-1,1);
    V(tt(ii-1)+1:tt(ii)-1)=vv+(1:tt(ii)-tt(ii-1)-1)'*vi;
    pp=V(tt(ii)-1)+vi;
  else
    pp=vv+vi;
  end
  Iobs=find(J==ii);
  nobs=length(Iobs);

  kk=pp*ones(1,nobs)/(ones(nobs,1)*pp*ones(1,nobs)+vo*eye(nobs));
  xx=(1-kk*ones(nobs,1))*xx+kk*Y(Iobs);
  vv=(1-kk*ones(nobs,1))*pp;
  
  % fprintf('[%g] xx=%g vv=%g\n',tt(ii),xx,vv);
  
  X(tt(ii))=xx;
  V(tt(ii))=vv;
end

T=T*dt;