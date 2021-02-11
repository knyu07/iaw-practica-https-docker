#!/bin/bash
# CERRTBOT

apt update
apt install apache2 -y

# Instala snapd y actualiza
snap install core; snap refresh core

# Eliminamos certbot-auto y cualquier paquete del sistema operativo Cerbot
apt-get remove certbot

# Instalamos Certbot
snap install --classic certbot

# Automatizamos la renovación
certbot --apache -m demo@demo.es --agree-tos -d practicahttpsdock.ml

