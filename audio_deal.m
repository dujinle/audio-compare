
tmp_file = './hello.wav';
tmp1_file = './hello1.wav';
save_file = './hello_data.s';
save1_file = './hello1_data.s';
[data,sample] = audioread(tmp_file);
[d1,s1] = audioread(tmp1_file);
save(save_file,'data');
save(save1_file,'d1');
data = double(data);
d1 = double(d1);
subplot(251);plot(data);title('ԭʼ���� ����');
subplot(256);plot(d1);title('ԭʼ���� ����');

data = filter([1 -0.9375],1,data);  %Ԥ����
d1 = filter([1 -0.9375],1,d1);      %Ԥ����
subplot(252);plot(data);title('Ԥ���� ����');
subplot(257);plot(d1);title('Ԥ���� ����');

[frame,t] = enframe(data,256,80);   %���ݷ�֡
[f1,t1] = enframe(d1,256,80);        %���ݷ�֡

m = creat_mel(frame,sample);
m1 = creat_mel(f1,s1);
subplot(253);plot(m);title('mel����ϵ�� ����');
subplot(258);plot(m1);title('mel����ϵ�� ����');

%����ÿ֡�� ���� �;�����
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

subplot(254);plot(cr(1,:));title('ÿ֡������ ����');
subplot(259);plot(cr1(1,:));title('ÿ֡������ ����');
subplot(2,5,5);plot(cr(2,:));title('ÿ֡�ľ����� ����');
subplot(2,5,10);plot(cr1(2,:));title('ÿ֡�ľ����� ����');
%{
%}