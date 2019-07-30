function [int2]=histAcum(img)

close all
%img=imread('C:\Users\Pedro\Desktop\lena.jpg');
%[w,H,c]=size(img);
[H,W,c]=size(img);
max1=max(max(img));
h=zeros(1,max1);
p=zeros(1,max1);
ha=zeros(1,max1);

%int=rgb2gray(img);
%[Width,Higth,ch]=size(lena(:,:,1));
%int=zeros(1,256);

for i=1:H
    for j=1:W
        pix=img(i,j)+1;
        h(pix)=h(pix)+1;
    end 
end

N=sum(h);
P=h/N;

%hs=P(1);
ha(1)=P(1);
for k=2:max1+1
    ha(k)=P(k)+ha(k-1);
end

int2=img;
for i=1:H
    for j=1:W
        k=img(i,j);
        n=255*ha(k+1);
        int2(i,j)=n;
    end 
end
int2;
% hist1=imhist(int);
% hist2=imhist(int2);
% figure(1),imshow(int,[]), title('Imagen original de LENA')
% figure(2),imshow(int2,[]), title('Imagen ecualizada de LENA')
% figure(3),imhist(int), title('Histograma original de LENA')
% figure(4),imhist(int2), title('Histograma ecualizado de LENA')
