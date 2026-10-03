#!/usr/bin/env bash
set -euo pipefail

# Roda as transformacoes SQL puras (staging -> dw) no BigQuery, na ordem
# correta. E o passo de transformacao do projeto: roda depois da ingestao
# (scripts/load_raw_to_bigquery.sh).
#
# Requisitos:
#   - gcloud CLI instalado e autenticado (gcloud auth login)
#
# Uso:
#   ./scripts/run_sql_transformations.sh SEU_PROJETO_ID [LOCALIZACAO]

PROJECT_ID="${1:?Uso: ./scripts/run_sql_transformations.sh SEU_PROJETO_ID [LOCALIZACAO]}"
LOCATION="${2:-US}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SQL_DIR="$SCRIPT_DIR/../sql"

echo "Projeto:      $PROJECT_ID"
echo "Localizacao:  $LOCATION"
echo

for dataset in northwind_staging northwind_dw; do
  bq --project_id="$PROJECT_ID" mk --dataset --location="$LOCATION" \
    "$PROJECT_ID:$dataset" 2>/dev/null && echo "Dataset $dataset criado." \
    || echo "Dataset $dataset ja existia, seguindo."
done
echo

echo "Rodando staging (views)..."
for f in "$SQL_DIR"/staging/*.sql; do
  echo "  -> $(basename "$f")"
  bq --project_id="$PROJECT_ID" query --use_legacy_sql=false < "$f" > /dev/null
done
echo

echo "Rodando dw (tabelas, na ordem numerica dos arquivos)..."
for f in $(ls "$SQL_DIR"/dw/*.sql | sort); do
  echo "  -> $(basename "$f")"
  bq --project_id="$PROJECT_ID" query --use_legacy_sql=false < "$f" > /dev/null
done

echo
echo "Concluido. Datasets northwind_staging e northwind_dw atualizados em $PROJECT_ID."
