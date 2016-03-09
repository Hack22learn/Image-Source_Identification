clc;clear all;close all;
% dr=uigetdir();
%dr='E:/images';
%list=dir([dr, '\*.JPG']);

len=3;

ST_Width=100;
ST_Height=100;

%pooled_feat=zeros(length(list),12,4);
pooled_feat=zeros(1,12,4);


tic;
for i=1:len
    im=imread(strcat('images/101_IMG_028',int2str(i+1),'.JPG'));
    im2{i}=imcrop(im,[1 1 ST_Width ST_Height]);
end
%images=gpuArray(imag);
parfor x=1:len
    display(x);
    imag=im2{x};
    [rowim,colim,three] = size(imag);

    if(rem(rowim/2,2)==0)
        rowfil=51;
    else
        rowfil=50;
    end

    if(rem(colim/2,2)==0)
        colfil=51;
    else
        colfil=50;
    end
display([rowim colim rowfil colfil rowim-rowfil+1 colim-colfil+1]);
    feature=zeros(12,rowim-rowfil+1,colim-colfil+1);
    feature = averandener(imag,rowim,colim,rowfil,colfil);
    feat = cornei(imag,rowim,colim,rowfil,colfil);
    for i=1:6
        feature(6+i,:,:)=feat(i,:,:);
    end    
    pooled_feat(x,:,:)=pool(feature);  
end
time_taken=toc;
display(time_taken);
for i=1:12
        csvwrite(strcat('Feature-',int2str(i),'.csv'),pooled_feat(:,i,:),0,1);
end
% T = table(pooled_feat(:,1,:),pooled_feat(:,2,:),pooled_feat(:,3,:),pooled_feat(:,4,:),pooled_feat(:,5,:),pooled_feat(:,6,:),pooled_feat(:,7,:),pooled_feat(:,8,:),pooled_feat(:,9,:),pooled_feat(:,10,:),pooled_feat(:,11,:),pooled_feat(:,12,:));
% filename = 'featurevectors_NONIQM_new.xls';
% writetable(T,filename,'Sheet',3,'WriteVariableNames',true);