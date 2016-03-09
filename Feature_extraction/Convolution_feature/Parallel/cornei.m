function [feature]=cornei(im,rowim,colim,rowfil,colfil)
rowc=rowim-rowfil+1;
colc=colim-colfil+1;
feature=zeros(6,rowc,colc);
    for i=1:rowc      %
            for j=1:colc  % Making patches of from the image
                temp=zeros(rowfil,colfil,3);          %
                for m=1:3          
                    
                    for k=0:rowfil-1
                        for l=0:colfil-1
                            temp(k+1,l+1,m)=double(im(i+k,j+l,m)); 
                        end
                    end
                      feature(m,i,j)=Neighbourpercolor(temp(:,:,m));
                end

                
              
                feature(4,i,j)=corr2(double(temp(:,:,1)),double(temp(:,:,2)));
                feature(5,i,j)=corr2(double(temp(:,:,2)),double(temp(:,:,3)));
                feature(6,i,j)=corr2(double(temp(:,:,3)),double(temp(:,:,1)));
              
            end
    end
end
    