FROM odoo:17.0
USER root
COPY conf/odoo.conf /etc/odoo
COPY conf/requirements.txt  /etc/odoo
COPY extra-addons /mnt/extra-addons
RUN pip3 install -r /etc/odoo/requirements.txt
USER odoo