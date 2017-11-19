function [data,sample] = wavread(filename)
%读取wav格式的文件 audioread 存在归一化操作 不是原始的数据
%研究起来有一些问题 故 重新编写wav数据解析函数
% filename wav文件 8k16bit 16k16bit alaw数据
% data wav数据的数据值
% sample wav文件的采样率
	fid = fopen(filename);
	riff = fgets(fid,4);
	if (isequal(riff,'RIFF') == 0)
		error('not the riff flag');
	end
	lens = fread(fid,1,'int');
	wave = fgets(fid,4);
	if (isequal(wave,'WAVE') == 0)
		error('not the wave flag');
	end
	fmt = fgets(fid,4);
	if (isequal(fmt,'fmt ') == 0)
		error('not the fmt');
	end
	fmt_size = fread(fid,1,'int');
	format = fread(fid,1,'short');
	channel = fread(fid,1,'short');
	sample = fread(fid,1,'int');
	datarate = fread(fid,1,'int');
	samnbit = fread(fid,1,'short');
	sambit = fread(fid,1,'short');
	dataflg = fgets(fid,4);
	if (isequal(dataflg,'data') == 0)
		fseek(fid,-4,0);
		fact = fgets(fid,4);
		if (isequal(fact,'fact') == 0)
			fseek(fid,-4,0);
			tmp = fread(fid,1,'short');
		end
	end
	dataflg = fgets(fid,4);
	if (isequal(dataflg,'data') == 0)
		fseek(fid,-4,0);
		fact = fgets(fid,4);
		if (isequal(fact,'fact') == 0)
			error('not found the data flag');
		else
			tmp = fread(fid,2,'int');
		end
	end
	dataflg = fgets(fid,4);
	if (isequal(dataflg,'data') == 0)
		error('not found the data flag');
	end
	datasize = fread(fid,1,'int');
	
	data = fread(fid,datasize,'char');
	format
	channel
	sample
	datarate
	samnbit
	sambit
	length(data)
	max_data = max(data);
	%data = data / max_data;
	save('./ttt.t','data');
end