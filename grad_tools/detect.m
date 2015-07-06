function dtcidx=detect(alm)

% ***機能***
% アラームの状態を格納した配列に対して，アラームがオフからオンに切
% り替わる点を見つける．

% ***入力***
% alm:アラームの状態を格納した配列

% ***出力***
% dtcidx:アラームがオフからオンに切り替わったインデックスの配列

% 質問等あればtosh.914@gmail.comにどうぞ．

dtc=zeros(length(alm),1);
dtc(2:end)=diff(alm);
dtcidx=find(dtc.*dtc+dtc);
