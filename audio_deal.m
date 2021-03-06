
tmp_file = './wavdata/jttqbc.wav';
%tmp1_file = './wavdata/hello1.wav';
%tmp1_file = './wavdata/wode.wav';
%tmp1_file = './wavdata/zhengqiang_hello1.wav';
tmp1_file = './wavdata/jttqbc1.wav';
[data,sample] = audioread(tmp_file);
[d1,s1] = audioread(tmp1_file);

subplot(2,6,1);plot(data);title('原始数据 样本');
subplot(2,6,7);plot(d1);title('原始数据 测试');

data = filter([1 -0.9375],1,data);  %预加重
d1 = filter([1 -0.9375],1,d1);      %预加重
subplot(2,6,2);plot(data);title('预加重 样本');
subplot(2,6,8);plot(d1);title('预加重 测试');

data = vad_data(data,256,80);
d1 = vad_data(d1,256,80);

subplot(2,6,3);plot(data);title('vad 样本');
subplot(2,6,9);plot(d1);title('vad 测试');

data = normalization(double(data),1);
d1 = normalization(double(d1),1);
subplot(2,6,4);plot(data);title('归一化 样本');
subplot(2,6,10);plot(d1);title('归一化 测试');



[frame,t] = enframe(data,256,80);   %分帧
[f1,t1] = enframe(d1,256,80);        %分帧


m = creat_mel(frame,sample);
m1 = creat_mel(f1,s1);
subplot(2,6,5);plot(m);title('mfcc 12个参数 样本');
subplot(2,6,11);plot(m1);title('mfcc 12个参数 测试');

%计算每一帧的质心 和 均方根
cr = centeroid(frame,32);
cr1 = centeroid(f1,32);

subplot(2,6,6);plot(cr(:,1)); hold on; plot(cr1(:,1));title('质心');legend('样本','测试');hold off;
subplot(2,6,12);plot(cr(:,2)); hold on; plot(cr1(:,2)); title('均方根');legend('样本','测试');hold off;
%dist1 = dtw(m,m1);
%disp(sprintf('%s->%s:mfcc dist:%f\n',tmp_file,tmp1_file,dist1));
%dist2 = dtw(cr,cr1);
%disp(sprintf('%s->%s:centeroid dist:%f\n',tmp_file,tmp1_file,dist2));

m_len = size(m,1);
m1_len = size(m1,1);
%判断是否 样本长度 大于 测试数据长度
k = m1_len - m_len;
disp(sprintf('%s->%s:frame laze:%d\n',tmp_file,tmp1_file,k));
if k <= 0
	mt = m1;
	crt = cr1;
	for i = 1:-k
		mt(end + i,:) = zeros(1,size(m,2));
		crt(end + i,:) = zeros(1,size(cr,2));
	end
	fdist = mel_comp(m,mt);
	disp(sprintf('%s->%s:mel comp dist:%f\n',tmp_file,tmp1_file,fdist));
	fc = compare_t(cr(:,1),crt(:,1));
	disp(sprintf('%s->%s:c comp dist:%f\n',tmp_file,tmp1_file,fc));
	fr = compare_t(cr(:,2),crt(:,2));
	disp(sprintf('%s->%s:r comp dist:%f\n',tmp_file,tmp1_file,fr));
else
	for i = 1:k
		mt = m1(i:m_len + i - 1,:);
		crt = cr1(i:m_len + i - 1,:);
		fdist = mel_comp(m,mt);
		disp(sprintf('%s->%s:mel comp dist:%f\n',tmp_file,tmp1_file,fdist));
		fc = compare_t(cr(:,1),crt(:,1));
		disp(sprintf('%s->%s:c comp dist:%f\n',tmp_file,tmp1_file,fc));
		fr = compare_t(cr(:,2),crt(:,2));
		disp(sprintf('%s->%s:r comp dist:%f\n',tmp_file,tmp1_file,fr));
	end
end
%{
%}