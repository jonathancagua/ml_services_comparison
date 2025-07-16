#!/bin/bash

echo "Construyendo y levantando servicios con Docker Compose..."

# Construir imágenes y ejecutar en segundo plano
docker-compose up --build -d

# Verificar que los contenedores están corriendo
echo ""
echo "Estado de los contenedores:"
docker-compose ps
