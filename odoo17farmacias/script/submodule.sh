#!/bin/bash
set -e

echo "🔁 Iniciando descarga/actualización de repositorios Odoo..."

BASE_PATH="odoo/17.0/extra-addons"
GITHUB_USER="inbrasolperu"  # Cambia si es otro

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

for repo in "${REPOS[@]}"; do
    path="$BASE_PATH/$repo"
    url="git@github.com:$GITHUB_USER/$repo.git"

    echo "➡️  Procesando $repo"

    if [ ! -d "$path" ]; then
        echo "📥 Clonando $repo en $path..."
        git clone -b 17.0 "$url" "$path"
    else
        echo "🔄 Actualizando $repo..."
        cd "$path"
        git fetch origin
        git checkout 17.0 || git checkout -b 17.0 origin/17.0
        git pull origin 17.0
        cd - > /dev/null
    fi

    echo "✅ Listo: $repo"
done

echo "🎉 Todos los repositorios se clonaron o actualizaron correctamente en el branch 17.0"