clc;clear all;close all;
pooled_feat=zeros(length(list),12,4)
for x=1:length(list)
   
    images{x}=imread([dr, '\', list(x).name]);
    feature=convexp(images{x});
    pooled_feat=pool(pooled_feat,feature,x);    
end

T = table(pooled_feat(:,1,:),pooled_feat(:,2,:),pooled_feat(:,3,:),pooled_feat(:,4,:),pooled_feat(:,5,:),pooled_feat(:,6,:),pooled_feat(:,7,:),pooled_feat(:,8,:),pooled_feat(:,9,:),pooled_feat(:,10,:),pooled_feat(:,11,:),pooled_feat(:,12,:));
filename = 'featurevectors_NONIQM_new.xls';
writetable(T,filename,'Sheet',3,'WriteVariableNames',true);