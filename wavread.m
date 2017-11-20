function [data,sample] = wavread(filename)
%��ȡwav��ʽ���ļ� audioread ���ڹ�һ������ ����ԭʼ������
%�о�������һЩ���� �� ���±�дwav���ݽ�������
% filename wav�ļ� 8k16bit 16k16bit alaw����
% data wav���ݵ�����ֵ
% sample wav�ļ��Ĳ�����
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
		error('not found the data flag');
	end

	datasize = fread(fid,1,'int');
	
	sample_size = datasize / samnbit;
	data = fread(fid,sample_size,'short');
	format
	channel
	sample
	datarate
	samnbit
	sambit
	length(data)
	max_data = max(data);
	data = data / max_data;
end