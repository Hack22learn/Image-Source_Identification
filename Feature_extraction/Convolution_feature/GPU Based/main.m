%Experimenting with convolution
clear all;
image=imread('dr-twitter.jpg');

filter=rand(10);
filSize=size(filter);

% %cpu based 
% data=image(:,:,1);
% %convolving
% convI=conv2(double(data),double(filter));
% imSize=size(convI);
% %croping to get our required data
% convI=convI(filSize(1):imSize(1)-filSize(1),filSize(2):imSize(2)-filSize(2));
% 
% averageD=mean(mean(convI));
% csvwrite('convolution.csv',averageD,0,1);

%GPU Based
data={image(:,:,1),image(:,:,2),image(:,:,3)};
res={[],[],[]};
gpuFilter=gpuArray(filter);
parfor i=1:3
    res{i}=convAverage(gpuArray(data{i}),gpuFilter);
   csvwrite(strcat('convolution-',int2str(i),'.csv'),res{i},0,1);
end