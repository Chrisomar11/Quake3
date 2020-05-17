#!/bin/bash

# Ajusta estas variables segun tu proyecto
export PROJECT_ID=neat-spark-277400
export CONTAINER_IMAGE=quake3:latest
export CLUSTER=cluster-1
export ZONE=us-central1-c

# Opcional: Solo en el caso de que tengas problemas con Python
export CLOUDSDK_PYTHON=/System/Library/Frameworks/Python.framework/Versions/2.7/bin/python

# Para MacOS:  brew install wget
# Para Ubuntu: apt-get install wget

# Si no tienes el pak0.pk3, lo descargará
# No se incluye el pak0.pk3 en este repositorio porque esta bajo licencia, se recomienda obtenerlo directamente desde el CD-ROM original.
PAK0=./baseq3/pak0.pk3
if [ -f "$PAK0" ]; then
    echo "$PAK0 ya lo tienes..."
else 
    wget -O ./baseq3/pak0.pk3 https://github.com/nrempel/q3-server/raw/master/baseq3/pak0.pk3
fi

# autenticarse
# gcloud auth login
gcloud config set project $PROJECT_ID

# Construir imagen docker
docker build -t quake3 .

# Subir imagen a register
gcloud auth configure-docker
docker tag $CONTAINER_IMAGE gcr.io/$PROJECT_ID/$CONTAINER_IMAGE
docker push gcr.io/$PROJECT_ID/$CONTAINER_IMAGE

# Conectarse a k8s e instalar imagen
gcloud container clusters get-credentials $CLUSTER --zone $ZONE --project $PROJECT_ID

# Opcional: Borrar el deploy en caso de lo necesites hacer
# kubectl delete -f deployment.yaml

# Instalar
kubectl apply -f deployment.yaml
kubectl apply -f services.yaml

# Ejecuta este comando para saber cual es la EXTERNAL-IP de tu nuevo servidor de Quake
# Ojo: la IP tarda aprox 3 minutos en crearse
kubectl get svc

# Comandos de ayuda
echo ""
echo ""
echo "Ver estado de creacion del deploy:"
echo "    kubectl get deployments"
echo ""
echo "Ver estado de creacion del deploy:"
echo "    kubectl get pods"
echo ""
echo "Ver estado de creacion del Balanceador de Carga:"
echo "    kubectl get svc"
echo ""
echo "Ver el log del pod"
echo "    kubectl get log NOMBRE_DEL_POD"
echo ""
echo "Proceso finalizado."
