FROM odoo:17.0

USER root
ENV DEBIAN_FRONTEND=noninteractive

# Instalar wkhtmltopdf y dependencias básicas
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget ca-certificates \
    xfonts-75dpi xfonts-base \
    fonts-dejavu fonts-liberation \
    && wget -q -O /tmp/wkhtmltox.deb "https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.jammy_amd64.deb" \
    && dpkg -i /tmp/wkhtmltox.deb || apt-get -f install -y \
    && rm -f /tmp/wkhtmltox.deb \
    && rm -rf /var/lib/apt/lists/*

# Copiar requisitos y extra-addons
COPY conf/requirements.txt /tmp/requirements.txt
COPY extra-addons /mnt/extra-addons

# Instalar dependencias Python y dar permisos
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt \
    && chown -R odoo:odoo /mnt/extra-addons \
    && rm /tmp/requirements.txt

USER odoo