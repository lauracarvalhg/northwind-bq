#!/usr/bin/env bash
set -euo pipefail

# Recria o dataset northwind_raw no BigQuery a partir dos arquivos parquet
# versionados em data/raw/. E o passo de ingestao do projeto: roda uma vez
# (ou sempre que quiser recarregar do zero) antes de executar o Dataform.
#
# Requisitos:
#   - gcloud CLI instalado e autenticado (gcloud auth login)
#   - projeto com a API do BigQuery ativada
#
# Uso:
#   ./scripts/load_raw_to_bigquery.sh SEU_PROJETO_ID [LOCALIZACAO]
#
# Exemplo:
#   ./scripts/load_raw_to_bigquery.sh empowerdata-aulas-sql US

PROJECT_ID="${1:?Uso: ./scripts/load_raw_to_bigquery.sh SEU_PROJETO_ID [LOCALIZACAO]}"
LOCATION="${2:-US}"
DATASET="northwind_raw"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="$SCRIPT_DIR/../data/raw"

echo "Projeto:      $PROJECT_ID"
echo "Dataset:      $DATASET"
echo "Localizacao:  $LOCATION"
echo

echo "Criando dataset (se ainda nao existir)..."
bq --project_id="$PROJECT_ID" mk --dataset \
  --location="$LOCATION" \
  --description "Dados brutos do Northwind, carregados dos arquivos parquet do repositorio northwind-bq" \
  "$PROJECT_ID:$DATASET" 2>/dev/null && echo "Dataset criado." || echo "Dataset ja existia, seguindo."
echo

TABELAS=(categories customers employee_territories employees order_details orders products shippers suppliers territories)

for tabela in "${TABELAS[@]}"; do
  echo "Carregando $tabela.parquet -> $DATASET.$tabela"
  bq --project_id="$PROJECT_ID" load \
    --source_format=PARQUET \
    --replace \
    "$DATASET.$tabela" \
    "$DATA_DIR/$tabela.parquet"
done

echo
echo "Concluido. As 10 tabelas do Northwind estao em $PROJECT_ID.$DATASET"
