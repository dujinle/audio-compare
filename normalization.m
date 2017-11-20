function desc = normalization(src,type)
%对数据进行归一化操作 1维数据
%src		原始数据集
%desc		目标数据集
%type		归一化的方法
%	1极值归一化 让数据集中的每一个数减去最小数再除以极差（数据集中的最大数减去最小数）
%	2方差归一化 数据集中的每一个数减去平均数（数据集的平均数）再除以方差
%	3最大归一化 数据集中每一个数除以最大数
	if type == 1
		dmin = min(src);
		dmax = max(src);
		desc = (src - dmin) / (dmax - dmin);
	elseif type == 2
		mean = sum(src) / length(src);
		desc = (src - mean) ./ sqrt((src.^2 - mean^2))
	elseif type == 3
		dmax = max(src);
		desc = src / dmax;
	end
end