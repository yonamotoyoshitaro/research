function [target]=targetanomalyscore()

%  計算対象の異常スコアを返却する
%{
    1. 中心性＋Hirose
    2. 中心性＋Ide
    3. 各ノードの中心性
    4. Hirose
    5. Ide
%}

target = [1, 1, 1, 1, 1];
%target = [0, 0, 0, 1, 0];