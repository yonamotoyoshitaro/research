function loss=loss_multiclass(yy, out)

[mm,ixy]=max(yy');
[mm,ixo]=max(out');

loss = 1-mean(ixy==ixo);