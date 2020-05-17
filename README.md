# ¿Cómo montar un servidor de Quake3 Arena?
# Docker / Kubernetes / Google Cloud Platform

<p align="center">
  <img src="https://raw.githubusercontent.com/freddylarag/quake3-server/master/quake3.png" alt="ioQuake3 Arena">
</p>

## Instalar quake3 Arena (en tu pc)
* Instrucciones para Mac Catalina: https://github.com/diegoulloao/ioquake3-mac-install
* Instrucciones para Windows 10: https://ioquake3.org/get-it/

## Generar la imagen de Docker (para el servidor)
* Construir Dockerfile: https://github.com/alcachofass/ioquake3container
* Conseguir las carpetas baseq3 y missionpack: https://ioquake3.org/get-it/
* Conseguir pak0.pk3: https://github.com/nrempel/q3-server/blob/master/baseq3/pak0.pk3
## Deploy (en GCP)
* Construir Cluster K8s
* Construir una deployment.yaml y service.yaml
* Jugar :)

