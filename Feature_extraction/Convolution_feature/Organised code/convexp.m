%function [feature] = convexp(image) 


    %% Average
    im=imread('kgp1.jpg');
    [rowim,colim,three] = size(im);

    if(rem(rowim/2,2)==0)
        rowfil=rowim/2+1;
    else
        rowfil=rowim/2;
    end

    if(rem(colim/2,2)==0)
        colfil=colim/2+1;
    else
        colfil=colim/2;
    end

    filter=ones(rowfil,colfil);
    filter = rot90(filter,2);



    r=im(:,:,1);
    g=im(:,:,2);
    b=im(:,:,3);

    temp(:,:,1)=conv2(double(im(:,:,1)),double(filter));
    temp(:,:,2)=conv2(double(im(:,:,2)),double(filter));
    temp(:,:,3)=conv2(double(im(:,:,3)),double(filter));
    [rowtemp,coltemp,three] = size(temp);
    count1=0;
    count2=0;
    feature=zeros(12,rowim-rowfil+1,colim-colfil+1);
    [rowc,colc,three] = size(average);
    for i=(rowtemp+1)/2-(rowc-1)/2:(rowtemp+1)/2+(rowc-1)/2
         count1=count1+1;
         count2=0;
         for j=(coltemp+1)/2-(colc-1)/2:(coltemp+1)/2+(colc-1)/2
             count2=count2+1;
             for k=1:three
                feature(k,count1,count2)=temp(i,j,k)/(rowfil*colfil);
                e(k,count1,count2)=power(temp(i,j,k),2);
             end

         end
    end

    %% Energy ratio
    
    feature(4,:,:)=e(2,:,:)./e(3,:,:);
    feature(5,:,:,1)=e(2,:,:)./e(1,:,:);
    feature(6,:,:)=e(3,:,:)./e(1,:,:);

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

            feature(7,i,j)=Neighbourpercolor(rtemp);
            feature(8,i,j)=Neighbourpercolor(gtemp);
            feature(9,i,j)=Neighbourpercolor(btemp);

            feature(10,i,j)=corr2(double(rtemp),double(gtemp));
            feature(11,i,j)=corr2(double(gtemp),double(btemp));
            feature(12,i,j)=corr2(double(btemp),double(gtemp));
        end
    end



%end

