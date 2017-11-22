
tmp_file = './wavdata/jttqbc.wav';
%tmp1_file = './wavdata/hello1.wav';
%tmp1_file = './wavdata/wode.wav';
tmp1_file = './wavdata/zhengqiang_hello1.wav';
[data,sample] = audioread(tmp_file);
[d1,s1] = audioread(tmp1_file);

subplot(2,6,1);plot(data);title('ԭʼ���� ����');
subplot(2,6,7);plot(d1);title('ԭʼ���� ����');

data = filter([1 -0.9375],1,data);  %Ԥ����
d1 = filter([1 -0.9375],1,d1);      %Ԥ����
subplot(2,6,2);plot(data);title('Ԥ���� ����');
subplot(2,6,8);plot(d1);title('Ԥ���� ����');

data = vad_data(data,256,80);
d1 = vad_data(d1,256,80);

subplot(2,6,3);plot(data);title('vad ����');
subplot(2,6,9);plot(d1);title('vad ����');

data = normalization(double(data),1);
d1 = normalization(double(d1),1);
subplot(2,6,4);plot(data);title('��һ�� ����');
subplot(2,6,10);plot(d1);title('��һ�� ����');



[frame,t] = enframe(data,256,80);   %��֡
[f1,t1] = enframe(d1,256,80);        %��֡


m = creat_mel(frame,sample);
m1 = creat_mel(f1,s1);
subplot(2,6,5);plot(m);title('mfcc 12������ ����');
subplot(2,6,11);plot(m1);title('mfcc 12������ ����');

%����ÿһ֡������ �� ������
cr = centeroid(frame,32);
cr1 = centeroid(f1,32);

subplot(2,6,6);plot(cr(:,1)); hold on; plot(cr1(:,1));title('����');legend('����','����');hold off;
subplot(2,6,12);plot(cr(:,2)); hold on; plot(cr1(:,2)); title('������');legend('����','����');hold off;
dist1 = dtw(m,m1);
disp(sprintf('%s->%s:mfcc dist:%f\n',tmp_file,tmp1_file,dist1));
dist2 = dtw(cr,cr1);
disp(sprintf('%s->%s:centeroid dist:%f\n',tmp_file,tmp1_file,dist2));
%{
%}