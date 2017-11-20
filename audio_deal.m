
tmp_file = './wavdata/hello.wav';
tmp1_file = './wavdata/hello1.wav';
[data,sample] = audioread(tmp_file);
[d1,s1] = audioread(tmp1_file);

data = double(data);
d1 = double(d1);
subplot(251);plot(data);title('原始数据 样本');
subplot(256);plot(d1);title('原始数据 测试');

data = filter([1 -0.9375],1,data);  %预加重
d1 = filter([1 -0.9375],1,d1);      %预加重
subplot(252);plot(data);title('预加重 样本');
subplot(257);plot(d1);title('预加重 测试');

[frame,t] = enframe(data,256,80);   %分帧
[f1,t1] = enframe(d1,256,80);        %分帧

%通过vad 进行有效语音检测 去除 静音段
[speech,silence] = vad(frame);
[sp1,si1] = vad(f1);

%获取语音片段
frame = frame(speech == 1,:);
f1 = f1(sp1 == 1,:);
subplot(253);plot(frame);title('vad 样本');
subplot(258);plot(f1);title('vad 测试');

m = creat_mel(frame,sample);
m1 = creat_mel(f1,s1);
subplot(254);plot(m);title('mfcc 12个参数 样本');
subplot(259);plot(m1);title('mfcc 12个参数 测试');

%计算每一帧的质心 和 均方根
cr = zeros(2,size(frame,1));
for i = 1:size(frame,1)
  y = frame(i,:);
  [c,r] = centeroid(y,32);
  cr(1,i) = c;
  cr(2,i) = r;
end

cr1 = zeros(2,size(f1,1));
for i = 1:size(f1,1)
  y = f1(i,:);
  [c,r] = centeroid(y,32);
  cr1(1,i) = c;
  cr1(2,i) = r;
end

subplot(255);plot(cr(1,:)); hold on; plot(cr1(1,:));title('质心');legend('样本','测试');hold off;
subplot(2,5,10);plot(cr(2,:)); hold on; plot(cr1(2,:)); title('均方根');legend('样本','测试');hold off;