function [xl,yl]=xyaxis(xl, yl, x_ogn, y_ogn)

if ~exist('x_ogn','var')
  x_ogn=0;
end

if ~exist('y_ogn','var')
  y_ogn=0;
end


hm = 0.2;
vm = 0.2;

if ~exist('xl','var')
  xl=xlim;
  width=diff(xl);
  xl=xl + width*[-hm hm];
  width=width*(1+2*hm);
else
  width=diff(xl);
end

if ~exist('yl','var')
  yl=ylim;
  height=diff(yl);
  yl=yl + height*[-vm vm];
  height=height*(1+2*vm);
else
  height=diff(yl);
end

hold on;
h=quiver([xl(1),x_ogn],[y_ogn,yl(1)],[width,0],[0,height],0);
set(h,'color','black');