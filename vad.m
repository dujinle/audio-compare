function [start,send] = vad(frame_data)
%�����˵��� �� ���ö�ʱ���� �� ������
% frame_data	�Ѿ���֡������
% speech  		����֡ �����ʾ
% silence		����֡ �����ʾ

	ste = size(frame_data,2);
	zcc = size(frame_data,2);
	for i = 1:size(frame_data,1)
		y = frame_data(i,:);
		ste(i) = sum(y.^2);
		zcc(i) = sum(y(1:end - 1) .* y(2:end) < 0);
	end
	subplot(411);plot(frame_data);title('�����ź�');xlabel('֡��');
	subplot(412);plot(ste);title('��ʱ����ֵ');xlabel('֡��');
	subplot(413);plot(zcc);title('������');xlabel('֡��');
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
	subplot(414);plot(frame_data(start:send,:));title('�жϽ��');xlabel('֡��');
end
