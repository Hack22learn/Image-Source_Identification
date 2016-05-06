function [pooled] = pool(feature)
    pooled=zeros(12,4);
    [twelve,ftrow,ftcol]=size(feature);
    for i=1:twelve
        pooled(i,1)=mean(mean(feature(i,1:round(ftrow/2),1:round(ftcol/2))));
        pooled(i,2)=mean(mean(feature(i,1:round(ftrow/2),round(ftcol/2)+1:ftcol)));
        pooled(i,3)=mean(mean(feature(i,round(ftrow/2)+1,1:round(ftcol/2))));
        pooled(i,4)=mean(mean(feature(i,round(ftrow/2)+1,round(ftcol/2)+1:ftcol)));
    end

end