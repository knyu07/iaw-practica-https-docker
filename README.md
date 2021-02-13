# Práctica: HTTPS con Let´s Encrypt, Docker y Docker Compose

Siguiendo con la práctica anterior haremos exactamente lo mismo pero de manera distinta. Creamos un dominio y expandiremos DNS antes de comenzar.

## Requisitos: 

Necesitaremos habilitar los puertos:
- Puerto 22
- Puerto 80
- Puerto 443
- Puerto 8080

Además de crear nuestro archivo docker-compose.yml y el archivo oculto .env

## Instalación

Para este archivo docker-compose vamos a crear los servicios: 

- phpmyadmin
- mysql
- prestashop

(Todo esto se han visto en anteriores prácticas)

Finalmente añadiremos el servicio **https-portal**

```
https-portal:
      image: steveltn/https-portal:1 
      ports:
        - 80:80 
        - 443:443
      restart: always
      environment:
        DOMAINS: 'https-docker.ml -> http://prestashop:80'
        STAGE: 'production'
      networks:
        - frontend-network
```
En la variable **DOMAINS** añadimos el nombre del dominio público y el nombre del servicio al que vamos a redireccionar todas las peticiones que se reciban por los puertos 80 y 443.

En la variable **STAGE** podemos añadir 3 valores distintos:

- **local**: Crea un certificado autofirmado para hacer pruebas en local.
- **straging**: Solicita un certificado de prueba a Let's Encrypt para nuestro entorno de pruebas.
- **production**: Solicita un certificado válido a Let's Encrypt. Esta opción sólo la usaremos para poner nuestro sitio web en producción. 

## Configuración de SSL en Prestashop

Una vez que hemos realizado la instalación de PrestaShop y hemos instalado un certificado en nuestro domino, tendremos que acceder al panel de administración (backofice) para activar las opciones de habilitar SSL y activar SSL en todas las páginas.

También es posible habilitar SSL modificando los valores de configuración **PS_SSL_ENABLED** y **PS_SSL_ENABLED_EVERYWHERE** directamente en la tabla **ps_configuration** de MySQL.

Para realizar este cambio, sólo tenemos que conectarnos a MySQL desde phpMyAdmin y ejecutar las siguientes sentencias SQL.

```
UPDATE ps_configuration SET value = '1' WHERE name = 'PS_SSL_ENABLED';
UPDATE ps_configuration SET value = '1' WHERE name = 'PS_SSL_ENABLED_EVERYWHERE';
```
