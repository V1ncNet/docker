# Invoiceplane Image & Stack

This image uses the php:7.4-apache-buster base image and the InvoicePlane [repository](https://github.com/InvoicePlane/InvoicePlane).

## Environment

- DB_HOSTNAME - Database host
- DB_USERNAME - Database user
- DB_PASSWORD - Database password
- DB_DATABASE - Database name
- DB_PORT - Database port

Each variable in the list may be configured as Docker Secret by appanding `_FILE`. E.g. `DB_PASSWORD_FILE`.

For a full list of InvoicePlane-related variables visit https://github.com/InvoicePlane/InvoicePlane/blob/master/ipconfig.php.example.

## Stack Deployment

```sh
docker-compose up -d --build
```

### Features/Images

- MySQL 5.7 database
- [InvoicePlane](https://github.com/V1ncNet/docker/tree/master/invoiceplane)

## Contribute

The source is available on [GitHub](https://github.com/V1ncNet/docker). Please [report any issues](https://github.com/V1ncNet/docker/issues).

To build the image from the Dockerfile run:

```sh
docker build -t vinado/invoiceplane:latest .
```
