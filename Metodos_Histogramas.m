%function [ output_args ] = Untitled3( input_args )

% Analisis de la imagen mediante Scripts

im = imread('partitura1.jpg');
%imshow(im)
%Determinamos las dimensaiones

[m n d] = size(im);

%Pasamos la imagen a contraste de intensidades
im_intensidad = zeros(m,n);


%Algoritmo de reduccion de tamaño
n_new = floor(n/3);
m_new = floor(m/3);
im_nueva = zeros(m,n);

% for k = 1:n_new
%     for j = 1:m_new
%         suma_valores = 0;
%         for i = 1:3 
%             for l = 1:3
%                 suma_valores = + suma_valores...
%                     +im(j*3+1-j,k*3+1-i);
%             end
%         end
%        im_nueva(j,k) = suma_valores/3; 
%     end
% end

%Funcion para pasar a binario la imagen
for i=1:m
    for j = 1:n
    im_intensidad(i,j) = logical(round(sum(im(i,j,:))/765));
    end
end

I = im_intensidad;
%Representamos

%figure;imshow(im_intensidad);

desp = 50;
amplitud = 50;

[hist_vertical hist_horizontal] = size(I);
floor(hist_vertical/desp)
hist_vertical = floor((hist_vertical-amplitud)/desp);
hist_horizontal = floor((hist_horizontal-amplitud)/desp);
hist_resultado = zeros(hist_vertical, hist_horizontal);


%Algoritmo de generación de sumatorio

[m n] = size(I);
I_sumatoria = zeros(m,n);
%I_sumatoria(1,1) = I(1,1);

for i = 1: m
    suma_fila = 0;
    for j = 1:n
        suma_fila = I(i,j)+suma_fila;
        if(i == 1)
            I_sumatoria(i,j) = suma_fila;
        else
            I_sumatoria(i,j) = suma_fila + I_sumatoria(i-1,j);
        end
    
    end
end


%Generar intensidades
for i = 1:hist_vertical
    for j = 1:hist_horizontal
        [values center] =...
            hist(I(((i-1)*desp+1):i*desp+amplitud,...
            ((j-1)*desp+1):j*desp+amplitud));
        hist_temp = sum(values(:,:)');
        hist_resultado(i,j) = hist_temp(end);
    end
end


imshow((hist_resultado))
