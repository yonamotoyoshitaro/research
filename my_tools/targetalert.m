function [target]=targetalert()

%  計算対象のアラートを返却する
%{
    1. 中心性＋Hirose
    2. 中心性＋Ide
    3. 各ノードの中心性
    4. ノードOR
    5. 中心性＋Hirose(中心性統合)
    6. 中心性＋Ide(中心性統合)
    7. ノードOR(中心性統合)
    8. Hirose
    9. Ide
%}
target = [1, 1, 1, 1, 1, 1, 1, 1, 1];
%target = [0, 0, 0, 0, 0, 0, 1, 0, 0];