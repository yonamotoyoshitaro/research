function [X, Y, memo]=load_baranzini(varargin)

opt=propertylist2struct(varargin{:});
opt=set_defaults(opt, 'bad',[153, 211],'fillnan',1);

S=importdata('/data/baranzini/journal.pbio.0030002.sd001.xls');

Ytmp=cell2mat(foreach(@isequal,S.textdata.Sheet1(2:end,1),[],'good'));

Gene=S.textdata.Sheet1(1,7:end-6);

id_sbj=S.data.Sheet1(:,1);

Ttmp=S.textdata.Sheet1(2:end,3);
Xtmp=S.data.Sheet1(:,6:end-6); 

% Clean up the data
Xtmp(opt.bad,:)=[];
id_sbj(opt.bad)=[];
Ytmp(opt.bad)=[];
Ttmp(opt.bad)=[];

if opt.fillnan
  Xtmp(isnan(Xtmp))=0;
end

ix=find(strcmp(Ttmp,'t0'));

X=Xtmp(ix,:);
Y=Ytmp(ix,:)*2-1;
id_sbj=id_sbj(ix);

memo.id_sbj=id_sbj;


[X,opt]=preproc_single_poly3(X,[],[]);

memo.optproc = opt;

function [F,opt] = preproc_single_poly3(X,label,opt)

[m,n]=size(X);

if ~isempty(label)
  Id1=cell(n,3);
  for ii=1:n
    Id1(ii,:) = {label{ii},[label{ii} '^2'],[label{ii} '^3']};
  end
end

F2  = zeros(m,3,n*(n-1)/2);
Id2 = cell(3,n*(n-1)/2);
ix=1;
for ii=1:n-1
  for jj=ii+1:n
    F2(:,:,ix)=[X(:,ii).*X(:,jj), X(:,ii).^2.*X(:,jj), X(:,ii).*X(:,jj).^2];
    if ~isempty(label)
      Id2(:,ix) = {[label{ii} '-' label{jj}];...
                   [label{ii} '.^2-' label{jj}];...
                   [label{ii} '-' label{jj} '.^2']};
    end
    ix=ix+1;
  end
end

F3  = zeros(m,n*(n-1)*(n-2)/6);
Id3 = cell(1,n*(n-1)*(n-2)/6);
ix=1;
for ii=1:n-2
  for jj=ii+1:n-1
    for kk=jj+1:n
      F3(:,ix)= [X(:,ii).*X(:,jj).*X(:,kk)];
      if ~isempty(label)
        Id3{ix} = [label{ii} '-' label{jj} '-' label{kk}];
      end
      ix=ix+1;
    end
  end
end

F  = [X, X.^2 X.^3 F2(:,:), F3(:,:)];

if ~isempty(label)
  Id = [Id1(:)' Id2(:)', Id3];
else
  Id = [];
end

[F,opt]=preproc_scalecenter(F,opt);

opt.Id=Id;


