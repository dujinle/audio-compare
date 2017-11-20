function cr = centeroid(frame,sub_bans)
% 计算音频的质心 和均方根 一帧为单位
% frame 音频分针的数据
% sub_bans 一帧音频的子带 划分
	cr = zeros(size(frame,1),2);
	m = zeros(1,sub_bans);
	k = size(frame,2) / sub_bans;
	for i = 1:size(frame,1)
		f = frame(i,:);
		mj = zeros(1,sub_bans);
		for j = 1:sub_bans
			sf = sum(f((j - 1) * k + 1:j * k).^2) / sub_bans;
			mj(j) = sqrt(sf);
		end
		ja = linspace(1,sub_bans,sub_bans);
		c = sum(mj .* ja) / sum(mj);
		r = sum(mj.^2) / sub_bans;
		cr(i,:) = [c,r];
	end
end