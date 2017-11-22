function dect = vad_data(data,sample_size,frame_len)
%语音端点检测 简单 利用短时能量 和 过零率
% data			音频数据
% sample_size	计算短时能量的采样大小
% frame_len		窗移长度
% dect  		有效语音数据

	%进行采样
	idx = 1;
	for i = 1:frame_len:length(data)
		endid = i - 1 + sample_size;
		if endid > length(data)
			y = data(i:end);
		else
			y = data(i:endid);
		end
		ste(idx) = sum(y.^2);
		zcc(idx) = sum(y(1:end - 1) .* y(2:end) < 0);
		idx = idx + 1;
	end
	%subplot(411);plot(data);title('语音信号');xlabel('帧数');
	%subplot(412);plot(ste);title('短时能量值');xlabel('帧数');
	%subplot(413);plot(zcc);title('过零率');xlabel('帧数');
	t_e = 10^-4;
	t_z = 30;
	
	dect = (ste > t_e) .* (zcc > t_z);
    start = 0;
    send = 0;
    for i = 1:length(dect) - 3
        sp = sum(dect(i:i + 3));
        if sp > 1 && start == 0
            start = i;
            break;
        end
    end
    for i = length(dect):-1:3
        sp = sum(dect(i - 3:i));
        if sp > 1 && send == 0
            send = i;
            break;
        end
    end
	%((start - 1)* frame_len + 1)
	%((send - 1)*frame_len + sample_size - 1)
	dect = data(((start - 1)* frame_len + 1):((send - 1)*frame_len + sample_size - 1));
	%subplot(414);plot(dect);title('判断结果');xlabel('帧数');
end
