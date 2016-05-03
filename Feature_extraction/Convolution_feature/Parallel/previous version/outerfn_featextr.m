clc;clear all;close all;

len=50;        % No of image files
ST_Width=512;   % Standard image file width
ST_Height=512;  % Standard image file height

%persistent counter;

pooled_feat=zeros(len,12,4);

tic;            %Start of the timer

for i=1:len
    im=imread(strcat('images/nikon/Nikkon-',int2str(i-1),'.JPG'));
    im2{i}=imcrop(im,[1 1 ST_Width ST_Height]);
end

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

%-----------------------------------------------
    feature=zeros(12,rowim-rowfil+1,colim-colfil+1);
    feature = averandener(imag,rowim,colim,rowfil,colfil);
    feat = cornei(imag,rowim,colim,rowfil,colfil);
    for i=1:6
        feature(6+i,:,:)=feat(i,:,:);
    end    
%-----------------------------------------------

    pooled_feat(x,:,:)=pool(feature);% Pooling controls how many inputs for an image is to be provide for a feature

  
end
time_taken=toc;
for i=1:12
    csvwrite(strcat('NIKKONFeature-',int2str(i),'.csv'),pooled_feat(:,i,:),0,1);
end
display(time_taken);