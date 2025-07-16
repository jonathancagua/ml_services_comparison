#!/bin/bash

# Lista de directorios a procesar
SERVICES=("grpc_service" "graphql_service" "rest_service")

# Script Python que entrena y guarda el modelo
PYTHON_CMD="import joblib; from sklearn.datasets import load_iris; from sklearn.linear_model import LogisticRegression; iris = load_iris(); X, y = iris.data, iris.target; model = LogisticRegression(max_iter=200); model.fit(X, y); joblib.dump(model, 'model.pkl'); print('Modelo entrenado y guardado como model.pkl')"

# Iterar por cada servicio
for SERVICE in "${SERVICES[@]}"; do
    if [ -d "$SERVICE" ]; then
        echo "Procesando $SERVICE..."
        cd "$SERVICE" || exit 1

        python -c "$PYTHON_CMD"

        cd - >/dev/null
    else
        echo "Directorio $SERVICE no encontrado. Omitiendo..."
    fi
done

echo "Todos los modelos fueron generados."
