FROM odoo:18.0

# Custom addons are baked into the image so the same artifact is scanned, tested and deployed.
COPY --chown=odoo:odoo ./addons /mnt/extra-addons
COPY --chown=odoo:odoo ./config/odoo.conf /etc/odoo/odoo.conf

USER odoo

HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=5 \
  CMD python3 -c "import urllib.request; urllib.request.urlopen('http://localhost:8069/web/health')" || exit 1
