function [start,send] = vad(frame_data)
%语音端点检测 简单 利用短时能量 和 过零率
% frame_data	已经分帧的数据
% speech  		语音帧 矩阵表示
% silence		静音帧 矩阵表示

	ste = size(frame_data,2);
	zcc = size(frame_data,2);
	for i = 1:size(frame_data,1)
		y = frame_data(i,:);
		ste(i) = sum(y.^2);
		zcc(i) = sum(y(1:end - 1) .* y(2:end) < 0);
	end
	subplot(411);plot(frame_data);title('语音信号');xlabel('帧数');
	subplot(412);plot(ste);title('短时能量值');xlabel('帧数');
	subplot(413);plot(zcc);title('过零率');xlabel('帧数');
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
	subplot(414);plot(frame_data(start:send,:));title('判断结果');xlabel('帧数');
end
