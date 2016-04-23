im = imread('esqueletos.jpg');
%im = imread('partitura1.jpg');
%imshow(im)
%Determinamos las dimensaiones

[m n d] = size(im);

%Pasamos la imagen a contraste de intensidades5
im_intensidad = zeros(m,n);

for i=1:m
    for j = 1:n
    im_intensidad(i,j) = logical(round(sum(im(i,j,:))/765));
    end
end


 I = im_intensidad;

 I_mejorada = I;
 %% Filtrado corrector
 for i=1:m
     for j=2:n-1
        if((I(i,j-1) == 0) && (I(i,j+1)==0))
            I_mejorada(i,j) = 0;
        end
     end
 end
 
  
 I = I_mejorada;
 
figure;imshow(I);
 
I_sum = Sum_pixel(I);


%%
% Filtrado de 3x51
filt = 51; %% Numero impar
sep_filt = (filt-1)/2;
%Filtrado de 1xfilt (la zona central suma las demas restan)
I_filter = zeros(m,n);

I_filter = I;

%Generar un filtrado de lineas centrado en la muestra central sep +1+sep
for i = 3:m-1
    for j = 1:n
        if(j <=  sep_filt+1)
            I_filter(i,j) = I_sum(i+1,j+sep_filt);
%             if (i ~= 1)
                 I_filter(i,j) = I_filter(i,j) - I_sum(i-2, j+sep_filt);
%             end
           
        elseif(j >= n - sep_filt+1)
            I_filter(i,j) = I_sum(i+1,end) - I_sum(i+1,j-sep_filt-1);
%             if (i ~= 1)
                I_filter(i,j) = I_filter(i,j) - I_sum(i-2,end)...
                                    + I_sum(i-2,j-sep_filt-1);
%             end
        else
            I_filter(i,j) = I_sum(i+1,j+sep_filt) - I_sum(i+1,j-sep_filt-1);
%             if (i ~= 1)
                I_filter(i,j) = I_filter(i,j) - I_sum(i-2,j+sep_filt)... 
                                        + I_sum(i-2,j-sep_filt-1);
%             end
        end
   end
end

%I_filter = logical(I_filter);
%%
%Representacion
I_filter(I_filter<=75) = 0; 
 figure; imshow(I_filter)
 
  I_notas_flotante = I  +(-logical(I_filter))+1;
 
  figure; imshow(I_notas_flotante);
%  
  figure; plot(sum(I_filter'))
    