%Algoritmo de transformacao DCT
%Autor : Douglas Diniz Landim, ra 76681
%email : ddlandim@unifesp.br

im = imread('in.pgm');
[l,a] = size(im);
b=8; % Bloco (8x8)
nb=(l/b)*(a/b); % Numero total de blocos

%MATRIZ T 8*8
T =  [0.3536  0.3536  0.3536  0.3536  0.3536  0.3536  0.3536  0.3536;
      0.4904  0.4157  0.2778  0.0975 -0.0975 -0.2778 -0.4157 -0.4904;
      0.4619  0.1913 -0.1913 -0.4619 -0.4619 -0.1913  0.1913  0.4619;
      0.4157 -0.0975 -0.4904 -0.2778  0.2778  0.4904  0.0975 -0.4157;
      0.3536 -0.3536 -0.3536  0.3536  0.3536 -0.3536 -0.3536  0.3536;
      0.2778 -0.4904  0.0975  0.4157 -0.4157 -0.0975  0.4904 -0.2778;
      0.1913 -0.4619  0.4619 -0.1913 -0.1913  0.4619 -0.4619  0.1913;
      0.0975 -0.2778  0.4157 -0.4904  0.4904 -0.4157  0.2778 -0.0975]; 
T = double(T);

TT = transpose(T);

%Matriz de quantizacao, gabaritos
Q50=[16  11  10  16  24  40  51  61;
      12  12  14  19  26  58  60  55;
      14  13  16  24  40  57  69  56;
      14  17  22  29  51  87  80  62;
      18  22  37  56  68 109 103  77;
      24  35  55  64  81 104 113  92;
      49  64  78  87 103 121 120 101;
      72  92  95  98 112 100 103  99];

Q90=[3  2  2  3  5  8 10 12;
     2  2  3  4  5 12 12 11;
     3  3  3  5  8 11 14 11;
     3  3  4  6 10 17 16 12;
     4  4  7 11 14 22 21 15;
     5  7 11 13 16 12 23 18;
     10 13 16 17 21 24 24 21;
     14 18 19 20 22 20 20 20];
 
%Selecao do gabarito para calculo
Q = Q90;
% Matriz M com os valores subtraídos por 128
M = double(im)-128;

% Formação de uma matriz de blocos b*b, para acessar cada bloco i - Block(:,:,i)
kk=0;
for i=1:(l/b)
    for j=1:(a/b)
        Block(:,:,kk+j)= M( double(b*(i-1)+1:b*(i-1)+b) , double(b*(j-1)+1:b*(j-1)+b) );
    end
kk=kk+(l/b);
end

%Conversao dos valores de pixels para double
Block = double(Block);

%Matriz de janelas D de multiplicação dos cossenos
M_J_D = Block;
for i=1:nb
    M_J_D(:,:,i) = T*Block(:,:,i)*TT; % D = TMT'
end

%Matriz de janelas de Quantizacao , divide a matriz D pela Matriz de
%Quantizacao e arredondamento para inteiro
M_J_C = M_J_D;
for i=1:nb
    M_J_C(:,:,i) = round(M_J_D(:,:,i)./Q);
end

%Descompressao
M_J_R = M_J_C;
for i=1:nb
    M_J_R(:,:,i) = M_J_C(:,:,i).*Q;
end

%IDCT
M_J_N = M_J_R;
for i=1:nb
    M_J_N(:,:,i) = round(TT * M_J_R(:,:,i) * T)+128;
end

%Rescrita da imagem, regravacao das janelas na matriz de saída
im_out = im;
kk=0;
for i=1:(l/b)
    for j=1:(a/b)
        M( double(b*(i-1)+1:b*(i-1)+b) , double(b*(j-1)+1:b*(j-1)+b) ) = M_J_N(:,:,kk+j);
    end
kk=kk+(l/b);
end

imwrite(im_out,'out_q90.pgm');






