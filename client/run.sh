#!/bin/bash

# Verificar que estamos en el directorio correcto
if [ ! -f "client.py" ] || [ ! -f "pyproject.toml" ]; then
    echo "Este script debe ejecutarse desde el directorio client/"
    exit 1
fi

echo "Generando archivos gRPC desde proto/ml_service.proto..."

poetry run python -m grpc_tools.protoc -I./proto \
    --python_out=. \
    --grpc_python_out=. \
    ./proto/ml_service.proto

echo "Archivos gRPC generados: ml_service_pb2.py y ml_service_pb2_grpc.py"

echo "Ejecutando client.py con poetry..."
poetry run python client.py
