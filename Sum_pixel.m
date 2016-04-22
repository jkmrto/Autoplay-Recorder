function [I_sumatoria ] = Sum_Pixel( I )
%UNTITLED3 Summary of this function goes here
%  This function provides the sumatory method necessary
%  to make the HAAR filter fast enough

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


end

