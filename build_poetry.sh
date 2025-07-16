#!/bin/bash

# Subdirectorios que deben ser procesados
SERVICES=("grpc_service" "graphql_service" "rest_service" "client")

# Función para generar los archivos de gRPC si aplica
generate_protobuf_files() {
    local service_dir=$1
    local proto_dir="$service_dir/proto"
    local proto_file="$proto_dir/ml_service.proto"

    if [ -f "$proto_file" ]; then
        echo "Generando archivos protobuf en $service_dir..."
        python -m grpc_tools.protoc -I "$proto_dir" \
            --python_out="$service_dir" \
            --grpc_python_out="$service_dir" \
            "$proto_file"
    fi
}

# Procesar cada servicio
for SERVICE in "${SERVICES[@]}"; do
    if [ -f "$SERVICE/pyproject.toml" ]; then
        echo "Procesando $SERVICE..."

        cd "$SERVICE" || exit 1

        echo "Ejecutando: poetry lock"
        poetry lock

        echo "Ejecutando: poetry install"
        poetry install

        cd - >/dev/null

        generate_protobuf_files "$SERVICE"
    else
        echo "No se encontró pyproject.toml en $SERVICE, omitiendo..."
    fi
done

# Crear README.md en client/ si no existe
if [ ! -f "client/README.md" ]; then
    echo "Creando client/README.md..."
    touch client/README.md
fi

echo "Proceso completo."
