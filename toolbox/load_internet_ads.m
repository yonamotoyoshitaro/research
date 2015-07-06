function [X,Y]=load_internet_ads(varargin)

opt=propertylist2struct(varargin{:});
opt=set_defaults(opt, 'fill_missing', 0);

m=3279;
n=1558;

fid=fopen('/data/uci/internet_ads/ad.data');

S=textscan(fid,[repmat('%f',[1,n]) '%s'],'Delimiter',',', ...
             'TreatAsEmpty',{'?'});
X=zeros(m,n);
for ii=1:size(X,2)
  X(:,ii)=S{ii};
end
Y=strcmp(S{end},'ad.')*2-1;

if opt.fill_missing
  X=fillnanmean(X);
end

