function [data,sample] = wavread(filename)
%读取wav格式的文件 audioread 存在归一化操作 不是原始的数据
%研究起来有一些问题 故 重新编写wav数据解析函数
% filename wav文件 8k16bit 16k16bit alaw数据
% data wav数据的数据值
% sample wav文件的采样率
