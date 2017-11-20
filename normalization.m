function desc = normalization(src,type)
%�����ݽ��й�һ������ 1ά����
%src		ԭʼ���ݼ�
%desc		Ŀ�����ݼ�
%type		��һ���ķ���
%	1��ֵ��һ�� �����ݼ��е�ÿһ������ȥ��С���ٳ��Լ�����ݼ��е��������ȥ��С����
%	2�����һ�� ���ݼ��е�ÿһ������ȥƽ���������ݼ���ƽ�������ٳ��Է���
%	3����һ�� ���ݼ���ÿһ�������������
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