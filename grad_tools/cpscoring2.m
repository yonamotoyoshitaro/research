function [cp]=cpscoring2(data,k1,T1,k2,T2,r)

% ***機能***
% 与えられた一次元データ配列に対する変化点スコアを二段階学習および平滑化
% によって計算する．スコアリングにはSDNML符号長を使う．誤差分散の推
% 定量の更新式に忘却を入れるパターン．

% ***入力***
% data:データ配列(一次元ベクトル)
% k1:第一段階学習におけるARモデルの次数．
% T1:第一段階スコアリングにおける平滑化幅．
% k2:第二段階学習におけるARモデルの次数．
% T2:第二段階スコアリングにおける平滑化幅．
% r:忘却係数

% ***出力***
% cp:変化点スコアの列．

% 質問等あればtosh.914@gmail.comにどうぞ．

sdnml1 = calcsdnmlcl2(data,k1,r);
nsdnml1 = normalize(sdnml1,T1);

sdnml2 = calcsdnmlcl2(nsdnml1,k2,r);
cp = normalize(sdnml2,T2);