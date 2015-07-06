function loss=loss_0_1(yy, out)

if isempty(yy) || isempty(out)
  warning('loss_0_1: One of the inputs is empty. NaN is returned.');
end

loss=mean((1-sign(yy.*out))/2);

