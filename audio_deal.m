
tmp_file = './wavdata/hello.wav';
%tmp1_file = './wavdata/hello1.wav';
%tmp1_file = './wavdata/wode.wav';
tmp1_file = './wavdata/zhengqiang_hello1.wav';
[data,sample] = audioread(tmp_file);
[d1,s1] = audioread(tmp1_file);

subplot(261);plot(data);title('原始数据 样本');
subplot(267);plot(d1);title('原始数据 测试');

data = normalization(double(data),1);
d1 = normalization(double(d1),1);
subplot(262);plot(data);title('归一化 样本');
subplot(268);plot(d1);title('归一化 测试');

data = filter([1 -0.9375],1,data);  %预加重
d1 = filter([1 -0.9375],1,d1);      %预加重
subplot(263);plot(data);title('预加重 样本');
subplot(269);plot(d1);title('预加重 测试');

[frame,t] = enframe(data,256,80);   %分帧
[f1,t1] = enframe(d1,256,80);        %分帧

%通过vad 进行有效语音检测 去除 静音段
[speech,silence] = vad(frame);
[sp1,si1] = vad(f1);

%获取语音片段
frame = frame(speech == 1,:);
f1 = f1(sp1 == 1,:);
subplot(2,6,4);plot(frame);title('vad 样本');
subplot(2,6,10);plot(f1);title('vad 测试');

m = creat_mel(frame,sample);
m1 = creat_mel(f1,s1);
subplot(2,6,5);plot(m);title('mfcc 12个参数 样本');
subplot(2,6,11);plot(m1);title('mfcc 12个参数 测试');

%计算每一帧的质心 和 均方根
cr = centeroid(frame,32);
cr1 = centeroid(f1,32);

subplot(2,6,6);plot(cr(:,1)); hold on; plot(cr1(:,1));title('质心');legend('样本','测试');hold off;
subplot(2,6,12);plot(cr(:,2)); hold on; plot(cr1(:,2)); title('均方根');legend('样本','测试');hold off;
dist1 = dtw(m,m1) / (size(m,1) * size(m1,1));
disp(sprintf('%s->%s:mfcc dist:%f\n',tmp_file,tmp1_file,dist1));
dist2 = dtw(cr,cr1)/(size(m,1) * size(m1,1));
disp(sprintf('%s->%s:centeroid dist:%f\n',tmp_file,tmp1_file,dist2));