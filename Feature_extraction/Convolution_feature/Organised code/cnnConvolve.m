function convolvedFeatures = cnnConvolve(filterDim, numFilters, images, W, b) 

 numImages = size(images, 3); 
 imageDim = size(images, 1); 
 convDim = imageDim - filterDim + 1; 
 convolvedFeatures = zeros(convDim, convDim, numFilters, numImages);
 for imageNum = 1:numImages 
   % AVERAGE PIXEL VALUE
     
     convolvedImage = zeros(convDim, convDim);  
     filter=ones(20,20)/25;
    
     % Fliping the feature matrix because of the definition of convolution
     filter = rot90(filter,2); 
        
     im = squeeze(images(:, :, imageNum)); 
      
     temp=conv2(im,filter);
     temp = convolvedImage + b;
     ti=0;
     tj=0;
     for i=(size(im,1)-convDim(1))/2:(size(temp,1)+convDim(1))/2
         ti=t1+1;
         for j=(size(im,2)-convDim(2))/2:(size(temp,2)-convDim(2))/2
            tj=tj+1;
             convolvedImage(ti,tj)=temp;
             
         end
     end

     convolvedFeatures(:, :, filterNum, imageNum) = convolvedImage; 
 end 
end 
 
 
 
 
 
