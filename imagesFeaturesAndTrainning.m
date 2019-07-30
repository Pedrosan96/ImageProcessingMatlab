%% Lectura de las imagenes
close all;  clear all;  clc; 
D='C:\Users\Pedro\Documents\Optimizacion de imagenes biomedicas\Imagenes\CBIS-DDSM';
[mamo, mammografias, gtnum, Masks]=imagesAdquisition(D);
gcomMammo=zeros(mamo,8,8);
hfeatMammo=zeros(mamo,14);
gcomMask=zeros(mamo,8,8);
%hfeatMask=NegativesFeatures(mammografias);
%% Features of each image

for i=2:2:gtnum
%    gcomMammo(i,:,:)=graycomatrix(mammografias(i).data,'offset',[0,1],'symmetric',true); 
    hfeat=haralickTextureFeatures(graycomatrix(Masks(i).data,'offset',[0,1],'symmetric',true),1:14);
    hfeatMammo(i,:)=hfeat';
end
% for i=2:2:gtnum
%     hfeat2=haralickTextureFeatures(graycomatrix(Masks(i).data,'offset',[0,1],'symmetric',true),1:14);
%     hfeatMask(i,:)=hfeat2';
% end

%% Trainning
X=[hfeatMammo;hfeatNeg];
Y=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,...
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
Y=Y.';

[ResSVM]=fitcsvm(X,Y);
YPred=predict(ResSVM,X)
%montage(X3, map1, 'Size', [2 2]);

%% New image

[img,map]=dicomread('C:\Users\Pedro\Desktop\CBIS-DDSM\Mass-Test_P_00017_LEFT_CC\10-04-2016-DDSM-12683\1-full mammogram images-82967\000000.dcm');
[imgMask,mapMask]=dicomread('C:\Users\Pedro\Desktop\CBIS-DDSM\Mass-Test_P_00017_LEFT_CC_1\10-04-2016-DDSM-30118\1-ROI mask images-03672\000000.dcm');
[imgGT,mapGT]=dicomread('C:\Users\Pedro\Desktop\CBIS-DDSM\Mass-Test_P_00017_LEFT_CC_1\10-04-2016-DDSM-30118\1-ROI mask images-03672\000001.dcm');
% [img,map]=dicomread('C:\Users\Pedro\Desktop\CBIS-DDSM\Mass-Test_P_00016_LEFT_MLO\10-04-2016-DDSM-54392\1-full mammogram images-35518\000000.dcm');
% [imgGT,mapGT]=dicomread('C:\Users\Pedro\Desktop\CBIS-DDSM\Mass-Test_P_00016_LEFT_MLO_1\10-04-2016-DDSM-15563\1-cropped images-77287\000000.dcm');
%img=imresize(img,0.25);
%img=MyMinMax(img,[0,255]);
%img=histAcum(img);
[H, W, Ch]=size(img);
img2=img;
img2(:,:)=0;
Yimg=zeros(round((H-200)/20),round((W-200)/20));
counter=0;
counter2=0;

for i=1:20:H-200
    for j=1:20:W-200
        gcomX=graycomatrix(img(i:i+200,j:j+200),'offset',[1 1],'symmetric',true); 
        hfeatX=haralickTextureFeatures(gcomX,1:14);
        Yres=predict(ResSVM,hfeatX');
        if (Yres==1)
            counter=counter+1;
            img2(i:i+200,j:i+200)=65535;
        end
    end
end
whos
figure(1),imshow(img,[]),figure(2),imshow(img2,[]);