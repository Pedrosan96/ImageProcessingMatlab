clear all; close all; clc
%Im=imread('C:\Users\Pedro\Desktop\lena.jpg');
%I1=double(rgb2gray(Im));
[I1,map]=dicomread('C:\Users\Pedro\Desktop\CBIS-DDSM\Mass-Test_P_00017_LEFT_CC\10-04-2016-DDSM-12683\1-full mammogram images-82967\000000.dcm');

[W, H]=size(I1);
h=imhist(I1/255);
%Normaizacion
N=sum(h);
p=h/N;
plot(p);
VBMax=0;
for i=2:255
    w1=sum(p(1:i));
    w2=sum(p(i+1:256));
    m1=sum((1:i)'.*p(1:i));
    m2=sum((i+1:256)'.*p(i+1:256));
    VB=w1*w2*(m1-m2)^2;
    if (VB>VBMax)
        VBMax=VB;
        Th=i;
    end
end

disp(Th);

I2=255*(I1>Th);
figure(2),imshow(I2,[])