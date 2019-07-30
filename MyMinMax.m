function [img2]=MyMinMax(img,rango)
%Funcion de nosrmalización MinMax
%img: es la imagen en escala de grises de entrada
%rango: el el vector con los nuevo valore máximos  minimos

%img=imread('C:\Users\Pedro\Desktop\lena.jpg');
%img=double(rgb2gray(img));
%[img,map]=dicomread('C:\Users\Pedro\Desktop\CBIS-DDSM\Calc-Test_P_00180_LEFT_CC\08-29-2017-DDSM-31108\1-full mammogram images-34705\000000.dcm');
%rango=[0,255];
[h,w,c]=size(img);
img2=img;

min1=min(min(img));
max1=max(max(img));
min2=rango(1);
max2=rango(2);
for i=1:h
    for j=1:w
        img2(i,j)=(img(i,j)-min1)*(max2-min2)/(max1-min1)+min2;
    end
end

figure(1),imshow(img,{}),figure(2),imshow(img2,{});

