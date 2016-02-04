function [c] = Neighbourpercolor(tempim)

jk = imhist(tempim); %count the number of pixels per intensity level [0..255]
% jk_n1 = zeros([256, 1]);
% jk_n1(1) = jk(2);
% jk_n1(256) = jk(255);
% for i = 2 : 255
%     jk_n1(i) = jk(i - 1) + jk(i + 1);
% end
%c_b(x) = mean(jk_n1);
gk_n1_t5 = sum((jk(2:254)-jk(1:253)) + (jk(2:254)+jk(3:255))); %hk[t-1]+hk[t+1]
gk_n1_t6 = sum((jk(3:255)-jk(2:254)) + (jk(3:255)+jk(4:256))); %hk[t-1]+hk[t+1]

c = gk_n1_t5 - gk_n1_t6;

end