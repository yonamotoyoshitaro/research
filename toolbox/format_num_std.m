function str = format_num_std(val)

mval=mean(val);
sval=std(val);

str= ['$' format_num_fixed(mval,3),...
      '$ ($\pm ' format_num_fixed(sval,3) '$) '];




