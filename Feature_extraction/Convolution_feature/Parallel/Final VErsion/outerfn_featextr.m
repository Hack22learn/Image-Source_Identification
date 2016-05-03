clc;clear all;close all;

len=46;        % No of image files
ST_Width = 512;   % Standard image file width
ST_Height = 512;  % Standard image file height

pooled_feat=zeros(len,12,4);

tic;            %Start of the timer

for i=1:len
    im=imread(strcat('images/nikon/Nikkon-',int2str(i+4-1),'.JPG'));
    [rs,cs,three]= size(im);
    if(rem(round(rs/2),2)==0)
	startr=round(rs/2)+1-(ST_Height/2);
    else 
	startr=round(rs/2)-(ST_Height/2);
    end
    if(rem(round(cs/2),2)==0)
	startc=round(cs/2)+1-(ST_Width/2);
    else 
	startc=round(cs/2)-(ST_Width/2);
    end
    im2{i}=imcrop(im,[startr startc ST_Width ST_Height]);
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

    pooled_feat(x,:,:)=pool(feature);       % Pooling controls how many inputs for an image is to be provide for a feature

  
end


temp_arr=zeros(12,len*4);
for i=1:12
    for j=1:len
        for k=1:4
            temp_arr(i,(j-1)*4+k)=pooled_feat(j,i,k);
        end
    end
end
csvwrite(strcat('testFeature.csv'),temp_arr);

time_taken=toc;
display(time_taken);