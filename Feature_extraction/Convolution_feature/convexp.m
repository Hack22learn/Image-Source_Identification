
clc;close all;clear all;
%% Average
three=3;
filter=ones(101,101);
filter = rot90(filter,2);
[rowfil,colfil] = size(filter);
im=imread('kgp1.jpg');

r=im(:,:,1);
g=im(:,:,2);
b=im(:,:,3);
[rowim,colim,three] = size(im);
temp(:,:,1)=conv2(double(im(:,:,1)),double(filter));
temp(:,:,2)=conv2(double(im(:,:,2)),double(filter));
temp(:,:,3)=conv2(double(im(:,:,3)),double(filter));
[rowtemp,coltemp,three] = size(temp);
count1=0;
count2=0;
average=zeros(rowim-rowfil+1,colim-colfil+1,three);
[rowc,colc,three] = size(average);
for i=(rowtemp+1)/2-(rowc-1)/2:(rowtemp+1)/2+(rowc-1)/2
     count1=count1+1;
     count2=0;
     for j=(coltemp+1)/2-(colc-1)/2:(coltemp+1)/2+(colc-1)/2
         count2=count2+1;
         for k=1:three
            average(count1,count2,k)=temp(i,j,k)/(25);
            e(k,count1,count2)=power(temp(i,j,k),2);
         end
         
     end
end

%% Energy ratio
ener=zeros(three,rowc,colc);
ener(1,:,:)=e(2,:,:)./e(3,:,:);
ener(2,:,:)=e(2,:,:)./e(1,:,:);
ener(3,:,:)=e(3,:,:)./e(1,:,:);

%% Correlation and neighbour fn calling

for i=1:rowc      %
    for j=1:colc  % Making patches of from the image
                  %
        for k=0:rowfil-1
            for l=0:colfil-1
                rtemp(k+1,l+1)=double(r(i+k,j+l)); 
                gtemp(k+1,l+1)=double(g(i+k,j+l));
                btemp(k+1,l+1)=double(b(i+k,j+l));
            end
        end
        
        n1(i,j)=Neighbourpercolor(rtemp);
        n2(i,j)=Neighbourpercolor(gtemp);
        n3(i,j)=Neighbourpercolor(btemp);
        
        rg(i,j)=corr2(double(rtemp),double(gtemp));
        gb(i,j)=corr2(double(gtemp),double(btemp));
        br(i,j)=corr2(double(btemp),double(gtemp));
    end
end
