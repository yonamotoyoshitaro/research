function ix=findmin_2d(loss, sz)

mm=min(loss);
ix=find(loss==mm);

if length(ix)>1
  [I,J]=ind2sub(sz,ix);
  
  loss=reshape(loss, sz);
  
  ii=findmin_medin(median(loss,2));
  jj=findmin_medin(median(loss));

  [mm,ix2]=min((I-ii).^2+(J-jj).^2);
  
  ix=ix(ix2);
end

  


