function [feature] = averandener(im,rowim,colim,rowfil,colfil)
    temp=zeros(3,rowim+rowfil-1,colim+colfil-1);
    filter=ones(rowfil,colfil);
    filter = rot90(filter,2);
    for i=1:3
        temp(i,:,:)=conv2(double(im(:,:,i)),double(filter));
    end
    
    [three,rowtemp,coltemp] = size(temp);
    

    
    feature=zeros(12,rowim-rowfil+1,colim-colfil+1);
    %[six,rowc,colc] = size(feature);
    rowc=rowim-rowfil+1;
    display(rowc);
    colc=colim-colfil+1;
    display(colc);
    % e=zeros(3,rowc,colc);
    xmin=round((coltemp+1)/2-(colc-1)/2);
    ymin=round((rowtemp+1)/2-(rowc-1)/2);
    
    for k=1:three
        feature(k,:,:)=temp(k,ymin:ymin+rowc-1,xmin:xmin+colc-1);
        
	e(k,:,:)=power(feature(k,:,:),2);
        feature(k,:,:)=feature(k,:,:)/(rowfil*colfil);
    end    
    display(size(feature));
    feature(4,:,:)=e(2,:,:)./e(3,:,:);
    feature(5,:,:,1)=e(2,:,:)./e(1,:,:);
    feature(6,:,:)=e(3,:,:)./e(1,:,:);
    display(size(feature));	
	
end