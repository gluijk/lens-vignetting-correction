# Corrección de viñeteo y dominantes en fotografía con R
# www.datosimagensonido.com

# Revelado lineal con DCRAW: dcraw -v -r 1 1 1 1 -o 0 -4 -T *.ARW

# Librería imágenes en 16 bits
library(tiff)

# Leemos patrón de viñeteo
vignet=readTIFF("vignet.tiff", native=F, convert=F)

# Normalizamos cada canal
for (i in 1:3) vignet[,,i]=vignet[,,i]/max(vignet[,,i])

# Aplicamos corrección a la escena y guardamos normalizando
# NOTA: ningún píxel de vignet puede valer 0 en ningún canal
scene.out=readTIFF("scene.tiff")/vignet
writeTIFF(scene.out/max(scene.out), "scene.out.tif",
          bits.per.sample=16, compression="LZW")

# Mapa de corrección
vignetlog=log(vignet)/log(2)  # Exposición relativa en EV

library(fields)
image.plot(vignetlog[,,1])  # Mapa del canal R
contour(vignetlog[,,1], add=T, levels=c(-1,-2,-3), method="edge")


