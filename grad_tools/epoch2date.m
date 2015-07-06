function [date_str] = epoch2date(epochTime)

% ***注意***
% これはhttp://ketul.com/blog/?tag=howtoで公開されていたコードを少々
% 書き換えたものです．

% ***機能***
% Unix時刻から日時の文字列(JST)を返す．

% ***入力***
% epochTime:Unix時刻

% ***出力***
% date_str:入力されたUnix時刻に対応する日時(JST)の文字列

% 質問等あればtosh.914@gmail.comにどうぞ．

% import java classes
import java.lang.System;
import java.text.SimpleDateFormat;
import java.util.Date;
% convert current system time if no input arguments
if (~exist('epochTime','var'))
    epochTime = System.currentTimeMillis/1000;
end
% convert epoch time (Date requires milliseconds)
jdate = Date(epochTime*1000);
% format text and convert to cell array
sdf = SimpleDateFormat('yyyy/MM/dd HH:mm');
date_str = sdf.format(jdate);
date_str = char(cell(date_str));