function [name]=centralityname(index)

% �C���f�b�N�X�ɊY�����钆�S���̖��O��ԋp����

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