function [n1,n2,n3] = neighbour(testim) 

r=testim(:,:,1);
g=testim(:,:,2);
b=testim(:,:,3);

n1=Neighbourpercolor(r);
n2=Neighbourpercolor(r);
n3=Neighbourpercolor(r);

end