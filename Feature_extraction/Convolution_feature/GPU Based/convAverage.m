function [ convRes ] = convAverage( channel,filter )

%Takes gpuArray(Image one channel) and %guuArray(filter)
% return 4 feature, in 4x1 matrix format

%Finding Convolution
convI=conv2(double(channel),double(filter));

%crop to get required convo image
imSize=size(convI);
filSize=size(filter);
convI=convI(filSize(1):imSize(1)-filSize(1),filSize(2):imSize(2)-filSize(2));

%finding Mean of all 4 frames, :Pooling
imSize=size(convI);
slicePoint=round(imSize/2);
convRes=[mean(mean(convI(1:slicePoint(1),1:slicePoint(2)))),mean(mean(convI(1:slicePoint(1),slicePoint(2)+1:imSize(2))))];
convRes=[convRes, mean(mean(convI(slicePoint(1)+1:imSize(1),1:slicePoint(2)))), mean(mean(convI(slicePoint(1)+1:imSize(1),slicePoint(2)+1:imSize(2))))];
end

% %% Method TO use this Trigger this function 
% data={image(:,:,1),image(:,:,2),image(:,:,3)};
% res={[],[],[]};
% gpuFilter=gpuArray(filter);
% parfor i=1:3
%     res{i}=convAverage(gpuArray(data{i}),gpuFilter);
%    csvwrite(strcat('convolution-',int2str(i),'.csv'),res{i},0,1);
% end