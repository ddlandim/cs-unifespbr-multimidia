"EP4: Faça um Stopmotion a partir de 30 fotos. 
Gere os vídeos usando FFMPEG. 
Entregue o link para um vídeo MPEG1, um vídeo H264 e um parágrafo com suas considerações sobre o exercício."		

######
FOTOS CAPTURAS: 59 fotos, total de 45,1mb

Propriedades das fotos:
1.JPG: JPEG image data, 
TIFF image data, big-endian, direntries=11, manufacturer=Apple, model=iPad, orientation=upper-right, xresolution=158, yresolution=166, resolutionunit=2, software=10.3.3, datetime=2018:09:13 16:19:58, GPS-Data], baseline, precision 8, 2592x1936, frames 3
tempo de exposição: 1/17seg
Valor da abertura focal: 2,53 EV
taxa de velocidade ISO: 50
distância focal: 4,3mm
##############################

VIDEO H264: O ARQUIVO PRODUZIDO FOI NA RESOLUÇÃO DE 2592*1936 NO TAMANHO DE: 17,4mb

comando: ffmpeg -r 30 -f image2 -s 2592x1936 -i %d.JPG -vcodec libx264 -crf 15 -pix_fmt yuv444p H264.mp4

yuv444p é um formato rgb (3 canais) com 24 pixels por componente
crf é um padrão de qualidade que utilizada tabelas quantizadoras na compressão, o valor varia de 1 a 51, sendo 1 o melhor e 51 o pior, foi utilizado 15.

[![VIDEO H264](http://img.youtube.com/vi/a5xfOu0FP_I/0.jpg)](http://www.youtube.com/watch?v=a5xfOu0FP_I)
######

VIDEO MPEG1: O ARQUIVO PRODUZIDO FOI NA RESOLUÇÃO DE 1366*768 NO TAMANHO DE: 852,0Kb

*não foi possível manter o mesmo padrão de qualidade no mpeg1, o comando a seguir gerava o erro: 
ffmpeg -i %d.JPG -s 2592x1936 -vcodec mpeg1video -crf 15 -pix_fmt yuv444p -maxrate 4444k -bufsize 4444k mpeg1.mpeg
*estouro de buffer 
mpeg1video @ 0x55a3e7208920] rc buffer underflow
mpeg1video @ 0x55a3e7208920] max bitrate possibly too small or try trellis with large lmax or increase qmax
mpeg @ 0x55a3e72079a0] buffer underflow st=0 bufi=552 size=83928

então foram utilizadas configurações default para MPEG1, que também apresentaram estouro de buffer:

ffmpeg -i %d.JPG -s 2592x1936 -vcodec mpeg1video mpeg1.mpeg
mpeg @ 0x55781c8838a0] packet too large, ignoring buffer limits to mux it
mpeg @ 0x55781c8838a0] buffer underflow st=0 bufi=274025 size=294652

então foi decidido diminuir a resolução do vídeo, que gerou o arquivo sem falhas:
ffmpeg -i %d.JPG -s 1366x768 -vcodec mpeg1video mpeg1.mpeg

[![VIDEO MPEG1](http://img.youtube.com/vi/UjqbG4vK4fs/0.jpg)](http://www.youtube.com/watch?v=UjqbG4vK4fs)
######

CONCLUSÃO: O arquivo mpeg1 teve um tamanho aproximadamente 17x menor que o h264, porem foi produzido em uma resolução menor também. 1366*768 comparada a 2592*1936. 5x menor aproximadamente.

na resolução que o h264 conseguiu comprimir, o mpeg1 estourou o buffer de compressão, significando um processo de compressão menos eficiente em termos de gerenciamento de memória.

o mpeg1 não permitiu configurações de framerate e também do formato de pixel de saída.

isso produziu um arquivo menor, com qualidade de vídeo menor também.
