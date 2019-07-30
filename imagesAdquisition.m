%%%}Funcion para la adquisicion de las imagenes de mamografias, mascaras y
%%% de groundtrue
function [Mm, mamografias, GT, mascaras]=imagesAdquisition(D)
%D='C:\Users\Pedro\Documents\Optimizacion de imagenes biomedicas\Imagenes\CBIS-DDSM';
cd (D)
cd mamograf
%carpMamog=dir('**/*mamm*');
%carpMask=dir('*/_1*');
%mamografias=zeros(numel(carpMamog));
%mascaras=zeros(numel(carpMask));
%j=1;

    %cd (carpMamog(i).folder)
    mamografias=dir ('**/*.dcm');
    %mammograf(j:j+numel(mamografias))=mamografias;
    for z = 1:numel(mamografias)
        F = fullfile(mamografias(z).folder,mamografias(z).name);
        I = dicomread(F);
        %figure(k),imshow(I)
        mamografias(z).data = I; % optional, save data.
    end
    %j=j+numel(mamografias)+1;
    

cd (D)
cd Mask1

    %cd (carpMask(i).folder)
    mascaras=dir ('**/*.dcm');
    %mascaras(j:j+numel(mask))=mask;
    for h = 1:numel(mascaras)
        P = fullfile(mascaras(h).folder,mascaras(h).name);
        Im = dicomread(P);
        %figure(h),imshow(Im)
        mascaras(h).data = Im; % optional, save data.
    end
    %j=j+numel(mask)+1;


    
[hight,width]=size(mamografias);
Mm=hight*width;
[hight1,width1]=size(mascaras);
GT=hight1*width1;
