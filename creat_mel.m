function m = creat_mel(frame,sample)
%生成12个mel倒谱系数
  bank = melbankm(24,256,sample,0,0.4,'t'); %Mel系数 
  bank = full(bank); %full() convert sparse matrix to full matrix
  bank = bank/max(bank(:));

  w = 1+6*sin(pi*[1:12]./12);%参数配置12个滤波器
  w = w/max(w);
  for k = 1:12
    n = 0:23;  
    dctcoef(k,:) = cos((2*n+1)*k*pi/(2*24));  
  end
  for i = 1:size(frame,1)
    y = frame(i,:);
    s = y' .* hamming(256);
    t = abs(fft(s));
    t = t.^2;
    c1 = dctcoef*log(bank*t(1:129));
    c2 = c1.*w';  
    m(i,:) = c2;
  end
end