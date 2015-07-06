function printFigure(figs, file, varargin)
% printFigure(figs, file, varargin)
%
% defaults:
%  'PaperPositionMode'  : 'auto'
%  'PaperOrientation'   : 'portrait'
%  'device'             : '-depsc2'

opt=propertylist2struct(varargin{:});
opt=set_defaults(opt, 'PaperPositionMode', 'auto',...
                      'device', '-depsc2');

for fig=figs
  fnames = fieldnames(get(fig));
  for i=1:length(fnames)
    if isfield(opt, fnames{i});
      set(fig, fnames{i}, getfield(opt, fnames{i}));
    end
  end

  name = get(fig,'name');
  if isempty(file) & ~isempty(name)
    file_save = name;
    file_save(strfind(file_save,' '))='_';
  else
    file_save = file;
  end
  
  print(fig, opt.device, file_save);
end
