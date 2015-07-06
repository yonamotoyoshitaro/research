function [name]=centralityname(index)

% インデックスに該当する中心性の名前を返却する

switch index
        case 1
            name = 'close';
        case 2
            name = 'degree';
        case 3
            name = 'eigenvector';
        case 4
            name = 'katz';
        case 5
            name = 'pagerank';
        case 6
            name = 'mmc1';
        case 7
            name = 'mmc2';
        case 8
            name = 'mmc3';
    otherwise
end