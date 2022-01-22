# InvoicePlane Image & Stack

This image uses the php:7.4-apache-buster base image, the [InvoicePlane repository](https://github.com/InvoicePlane/InvoicePlane) and the Apache HTTP server (httpd).

## Environment

- DB_HOSTNAME - Database host
- DB_USERNAME - Database user
- DB_PASSWORD - Database password
- DB_DATABASE - Database name
- DB_PORT - Database port
- IP_URL - URL without trailing slash (mandatory)

As an alternative to passing sensitive information via environment variables, _FILE may be appended to some previously listed environment variables. This is only supported for `DB_USERNAME`, `DB_PASSWORD`, `DB_DATABASE`.

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
