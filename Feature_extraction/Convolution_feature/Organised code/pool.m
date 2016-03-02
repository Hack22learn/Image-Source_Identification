function [pooled] = pool(pooled,feature,imno)

ftsize=size(feature);
for i=1:12
    sum=0;count=0;
    for k=1:ftsize(2)/2
       for l=1:ftsize(3)/2
          sum=sum+feature(i,k,l); 
          count=count+1;
       end
    end
    pooled(imno,i,1)=sum/count;
    count=0;sum=0;
    for k=1:ftsize(2)/2
       for l=ftsize(3)/2+1:ftsize(3)
          sum=sum+feature(i,k,l); 
          count=count+1;
       end
    end
    pooled(imno,i,2)=sum/count;
    count=0;sum=0;
    for k=ftsize(2)/2+1:ftsize(2)
       for l=1:ftsize(3)/2
          sum=sum+feature(i,k,l); 
          count=count+1;
       end
    end
    pooled(imno,i,3)=sum/count;
    count=0;sum=0;
    for k=ftsize(2)/2+1:ftsize(2)
       for l=ftsize(3)/2+1:ftsize(3)
          sum=sum+feature(i,k,l); 
          count=count+1;
       end
    end
    pooled(imno,i,4)=sum/count;
end

end