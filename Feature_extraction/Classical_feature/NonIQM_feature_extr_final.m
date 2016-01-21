function [] = NonIQM_feature_extr_final()
%NON_IQM_Metrics
% clc;
% close all;
% clear all;

dr=uigetdir();

list=dir([dr, '\*.jpg']);        %here jpg is file extension of the images

for x=1:length(list)
    %Avg pixel values
    images{x}=imread([dr, '\', list(x).name]);
    meanImage = mean(mean(images{x}));
    meanR(x) = meanImage(:,:,1);
    meanG(x) = meanImage(:,:,2);
    meanB(x) = meanImage(:,:,3);
    c = images{x};
    r = c(:,:,1);
    g = c(:,:,2);
    b = c(:,:,3);
    Er = sum(r(:));
    Eg = sum(g(:));
    Eb = sum(b(:));
    E1(x) = Eg ./ Eb;
    E2(x) = Eg ./ Er;
    E3(x) = Eb ./ Er;
    %Neighbor distribution centre of mass (for example: r channel only)
    hk = imhist(r); %count the number of pixels per intensity level [0..255]
    gk_n1 = zeros([256, 1]);
    gk_n1(1) = hk(2);
    gk_n1(256) = hk(255);
    for i = 2 : 255
        gk_n1(i) = hk(i - 1) + hk(i + 1);
    end
    %c_r(x) = mean(gk_n1);
    gk_n1_t1 = sum((hk(2:254)-hk(1:253)) + (hk(2:254)+hk(3:255))); %hk[t-1]+hk[t+1]
    gk_n1_t2 = sum((hk(3:255)-hk(2:254)) + (hk(3:255)+hk(4:256))); %hk[t-1]+hk[t+1]
    
    dk_s(x) = gk_n1_t1 - gk_n1_t2;
    %argMin_ds = find(ds==min(ds(find(ds>=0))))
    
    %Neighbor distribution centre of mass (for example: g channel only)
    ik = imhist(g); %count the number of pixels per intensity level [0..255]
    ik_n1 = zeros([256, 1]);
    ik_n1(1) = ik(2);
    ik_n1(256) = ik(255);
    for i = 2 : 255
        ik_n1(i) = ik(i - 1) + ik(i + 1);
    end
    %c_g(x) = mean(ik_n1);
    gk_n1_t3 = sum((ik(2:254)-ik(1:253)) + (ik(2:254)+ik(3:255))); %hk[t-1]+hk[t+1]
    gk_n1_t4 = sum((ik(3:255)-ik(2:254)) + (ik(3:255)+ik(4:256))); %hk[t-1]+hk[t+1]
    
    dk_t(x) = gk_n1_t3 - gk_n1_t4;
    
    %Neighbor distribution centre of mass (for example: b channel only)
    jk = imhist(b); %count the number of pixels per intensity level [0..255]
    jk_n1 = zeros([256, 1]);
    jk_n1(1) = jk(2);
    jk_n1(256) = jk(255);
    for i = 2 : 255
        jk_n1(i) = jk(i - 1) + jk(i + 1);
    end
    %c_b(x) = mean(jk_n1);
    gk_n1_t5 = sum((jk(2:254)-jk(1:253)) + (jk(2:254)+jk(3:255))); %hk[t-1]+hk[t+1]
    gk_n1_t6 = sum((jk(3:255)-jk(2:254)) + (jk(3:255)+jk(4:256))); %hk[t-1]+hk[t+1]
    
    dk_u(x) = gk_n1_t5 - gk_n1_t6;
    RG(x) = corr2(r, g);
    GB(x) = corr2(g, b);
    BR(x) = corr2(b, r);
end

T = table(meanR', meanG', meanB', E1', E2', E3', dk_s', dk_t', dk_u', RG', GB', BR');
T(1:12,:)
filename = 'featurevectors_NONIQM_new.xls';
writetable(T,filename,'Sheet',3,'WriteVariableNames',true);
end