
tmp_file = './wavdata/hello.wav';
tmp1_file = './wavdata/hello1.wav';
%tmp1_file = './wavdata/zhengqiang_hello1.wav';
[data,sample] = audioread(tmp_file);
[d1,s1] = audioread(tmp1_file);

subplot(261);plot(data);title('ԭʼ���� ����');
subplot(267);plot(d1);title('ԭʼ���� ����');

data = normalization(double(data),1);
d1 = normalization(double(d1),1);
subplot(262);plot(data);title('��һ�� ����');
subplot(268);plot(d1);title('��һ�� ����');

data = filter([1 -0.9375],1,data);  %Ԥ����
d1 = filter([1 -0.9375],1,d1);      %Ԥ����
subplot(263);plot(data);title('Ԥ���� ����');
subplot(269);plot(d1);title('Ԥ���� ����');

[frame,t] = enframe(data,256,80);   %��֡
[f1,t1] = enframe(d1,256,80);        %��֡

%ͨ��vad ������Ч������� ȥ�� ������
[speech,silence] = vad(frame);
[sp1,si1] = vad(f1);

%��ȡ����Ƭ��
frame = frame(speech == 1,:);
f1 = f1(sp1 == 1,:);
subplot(2,6,4);plot(frame);title('vad ����');
subplot(2,6,10);plot(f1);title('vad ����');

m = creat_mel(frame,sample);
m1 = creat_mel(f1,s1);
subplot(2,6,5);plot(m);title('mfcc 12������ ����');
subplot(2,6,11);plot(m1);title('mfcc 12������ ����');

%����ÿһ֡������ �� ������
cr = centeroid(frame,32);
cr1 = centeroid(f1,32);

subplot(2,6,6);plot(cr(:,1)); hold on; plot(cr1(:,1));title('����');legend('����','����');hold off;
subplot(2,6,12);plot(cr(:,2)); hold on; plot(cr1(:,2)); title('������');legend('����','����');hold off;
dist1 = dtw(m,m1) / (size(m,1) * size(m1,1));
dist1
dist2 = dtw(cr,cr1)/(size(m,1) * size(m1,1));
dist2