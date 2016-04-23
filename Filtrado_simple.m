%%
% Filtrado basado en modulos simples
filt = 51; %% Numero impar
sep_filt = (filt-1)/2;
%Filtrado de 1xfilt (la zona central suma las demas restan)
I_filter = zeros(m,n);

% Hay un pequeño error para las muestras cercanas a j ===1
%Generar un filtrado de lineas centrado en la muestra central sep +1+sep
for i = 1:m
    for j = 1:n
        if(j <=  sep_filt+1)
            I_filter(i,j) = I_sum(i,j+sep_filt);
            if (i ~= 1)
                I_filter(i,j) = I_filter(i,j) - I_sum(i-1, j+sep_filt);
            end
        elseif(j >= n - sep_filt+1)
            I_filter(i,j) = I_sum(i,end) - I_sum(i,j-sep_filt-1);
            if (i ~= 1)
                I_filter(i,j) = I_filter(i,j) - I_sum(i-1,end)...
                                    + I_sum(i-1,j-sep_filt-1);
            end
        else
            I_filter(i,j) = I_sum(i,j+sep_filt) - I_sum(i,j-sep_filt-1);
            if (i ~= 1)
                I_filter(i,j) = I_filter(i,j) - I_sum(i-1,j+sep_filt)... 
                                        + I_sum(i-1,j-sep_filt-1);
            end
        end
   end
end
