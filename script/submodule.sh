#!/bin/bash
set -e

echo "🔁 Iniciando adición/actualización de submódulos Odoo..."

BASE_PATH="extra-addons"
GITHUB_USER="Inbrasol"

REPOS=(
  "localization_pe_contact"
  "themes"
  "localization_pe_l10n_pe"
  "crm"
  "calendar"
  "storage"
  "server-tools"
  "extra_tools"
  "social"
  "stock-logistics-warehouse"
  "stock-logistics-workflow"
  "point_of_sale"
  "website_sale"
  "website"
  "purchase"
  "sale"
  "contact"
)

# Verifica si ya están registrados en .gitmodules
function is_registered_submodule() {
  grep -q "$1" .gitmodules 2>/dev/null
}

# Paso 1: Agrega submódulos si no existen
for repo in "${REPOS[@]}"; do
  repo_url="https://github.com/$GITHUB_USER/$repo.git"
  submodule_path="$BASE_PATH/$repo"

  if [ ! -d "$submodule_path/.git" ]; then
    if is_registered_submodule "$submodule_path"; then
      echo "⚠️  Submódulo ya registrado en .gitmodules: $repo"
    else
      echo "📌 Agregando submódulo: $repo"
      git submodule add -b 17.0 "$repo_url" "$submodule_path"
    fi
  else
    echo "🔄 Submódulo ya clonado: $repo"
  fi
done

# Paso 2: Inicializa y actualiza submódulos
echo "📦 Inicializando y actualizando todos los submódulos..."
git submodule update --init --recursive

# Paso 3: Forzar a usar la rama 17.0 en cada submódulo
for repo in "${REPOS[@]}"; do
  submodule_path="$BASE_PATH/$repo"
  echo "🔁 Actualizando $repo a la rama 17.0..."

  if [ -d "$submodule_path/.git" ]; then
    pushd "$submodule_path" > /dev/null
    git fetch origin
    git checkout 17.0 || git checkout -b 17.0 origin/17.0
    git pull origin 17.0
    popd > /dev/null
  else
    echo "⛔ No se encontró la carpeta del submódulo: $repo"
  fi
done

echo "✅ ¡Todos los submódulos se encuentran en la rama 17.0 y actualizados!"