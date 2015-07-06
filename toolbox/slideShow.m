function slideShow(ev, range, varargin)
% slideShow - interactive plot of 1d array.
% 
% slideShow(EV, RANGE, 'varname1', VALUE1, 'varname2', VALUE2,...)
% inputs:
%  EV     : a string with a single int argument as 'i'.
%  RANGE  : the range of the index to run.
%  variable / value list :
%     specify all variables necessary in evaluating EV.
%  'ev_title' is a special variable that can be evaluated
%          in the callback (e.g., 'labels{i}') to generate
%          the title. Default  'sprintf(ev, i)'.
%
% Ryota Aug 2006

opt = propertylist2struct(varargin{:});

if ~isfield(opt,'bSS_ignore_others')
  opt.bSS_ignore_others = 1;
end
range = [min(range) max(range)];

fig = figure;
set(fig, 'KeyPressFcn',{@cbSlideShow, ev, range, opt, fig});
cbSlideShow([],[], ev, range, setfield(opt, 'slideShow_initialize', 1), fig);


function cbSlideShow(obj, eventdata, ev_cbss, range_cbss, opt_cbss, fig)

persistent index_all;

c = get(gcf, 'CurrentCharacter');

figname=['f' num2str(fig)];
if isfield(opt_cbss,'slideShow_initialize') & opt_cbss.slideShow_initialize
  i=range_cbss(1);
  index_all=setfield(index_all, figname, i);
else
  i=getfield(index_all, figname);
  switch(c)
   case {'n',' ', 31}
    i = i + 1;
   case {'p', 8, 30}
    i = i - 1;
   case {'N', 29}
    i = i + 10;
   case {'P' 28}
    i = i - 10;
   case '1'
    i = range_cbss(1);
   case '2'
    i = range_cbss(end);
   case 'r'
    %% refresh
   otherwise
    fprintf('%d\n',c);
    if opt_cbss.bSS_ignore_others
      return;
    end
  end
  if i<range_cbss(1), i=range_cbss(1); end
  if i>range_cbss(end), i=range_cbss(end); end

  index_all=setfield(index_all, figname, i);
end


%% Auto cleanup
index_all_fields=fieldnames(index_all);
for k=1:length(index_all_fields)
  figidk=eval(index_all_fields{k}(2:end));
  try
    kpf=get(figidk,'KeyPressFcn');
  catch
    index_all=rmfield(index_all, index_all_fields{k});
  end
end


figure(fig);
clf;

extract(opt_cbss);
eval(ev_cbss);

if isfield(opt_cbss, 'ev_title')
  if ~isempty(opt_cbss.ev_title)
    ttl = eval(opt_cbss.ev_title);
  else
    ttl = [];
  end
else
  ttl = sprintf('[%d] %s', i, ev_cbss);
end

if ~isempty(ttl)
  title(ttl, 'interpreter','none');
end

