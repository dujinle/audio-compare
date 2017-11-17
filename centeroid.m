function [c,r] = centeroid(f,sub_bans)
% 计算一帧音频的质心 和均方根
% f 一帧音频的数据
% sub_bans 一帧音频的子带 划分
  m = zeros(1,sub_bans);
  j = length(f) / sub_bans;
  idx = 0;
  step = 1;
  while idx < length(f)
    mt = 0;
    for i = 1:j
      mt = mt + (f(idx + i))^2;
    end
    m(step) = sqrt(mt / j);
    step = step + 1;
    idx = idx + j;
  end
  jm = 0;
  mm = 0;
  m2 = 0;
  for i = 1:sub_bans
    jm = jm + i * m(i);
    mm = mm + m(i);
    m2 = m2 + m(i)^2;
  end
  c = jm / mm;
  r = sqrt(m2 / sub_bans);
end