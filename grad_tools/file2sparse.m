function [scoremat,wordmat]=file2sparse(scorefile,wordfile)

% ***機能***
% calcscore.pyおよびcountword.pyで作ったCSVファイルから，リンクの異
% 常値および単語の登場数をスパース行列に格納する．
% 列番号が時間に対応し，行番号がユーザに対応する．

% ***入力***
% scorefile:パスを含めた，スコアのCSVファイル名の文字列
% wordfile:パスを含めた，単語のCSVファイル名の文字列

% ***出力***
% scoremat:スコアのスパース行列
% wordmat:単語数のスパース行列

% 質問等あればtosh.914@gmail.comにどうぞ．

X = importdata(scorefile);
Y = importdata(wordfile);
XU = X.textdata;
XT = X.data(:,1);
XS = X.data(:,2);
YU = Y.textdata;
YT = Y.data(:,1);
YN = Y.data(:,2);

[Xuuser,IXa,IXuser] = unique(XU);
[Yuuser,IYa,IYuser] = unique(YU);

t0 = min([XT;YT]);
XT = XT - t0 + 1;
YT = YT - t0 + 1;

scoremat = sparse(IXuser,XT,XS);
wordmat = sparse(IYuser,YT,YN);