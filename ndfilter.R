# Correcci�n de vi�eteo y dominantes en fotograf�a con R
# www.datosimagensonido.com

# Revelado lineal con DCRAW: dcraw -v -r 1 1 1 1 -o 0 -4 -T *.ARW

# Librer�a im�genes en 16 bits
library(tiff)

# Leemos patr�n de vi�eteo
vignet=readTIFF("vignet.tiff", native=F, convert=F)

# Normalizamos cada canal
for (i in 1:3) vignet[,,i]=vignet[,,i]/max(vignet[,,i])

# Aplicamos correcci�n a la escena y guardamos normalizando
# NOTA: ning�n p�xel de vignet puede valer 0 en ning�n canal
scene.out=readTIFF("scene.tiff")/vignet
writeTIFF(scene.out/max(scene.out), "scene.out.tif",
          bits.per.sample=16, compression="LZW")

# Mapa de correcci�n
vignetlog=log(vignet)/log(2)  # Exposici�n relativa en EV

library(fields)
image.plot(vignetlog[,,1])  # Mapa del canal R
contour(vignetlog[,,1], add=T, levels=c(-1,-2,-3), method="edge")

