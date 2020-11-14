#!/bin/bash
set -eu

run_as() {
    if [ "$(id -u)" = 0 ]; then
        su -p www-data -s /bin/sh -c "$1"
    else
        sh -c "$1"
    fi
}

file_env() {
    local var="$1"
    local fileVar="${var}_FILE"
    local def="${2:-}"
    local varValue=$(env | grep -E "^${var}=" | sed -E -e "s/^${var}=//")
    local fileVarValue=$(env | grep -E "^${fileVar}=" | sed -E -e "s/^${fileVar}=//")

    if [ -n "${varValue}" ] && [ -n "${fileVarValue}" ]; then
        echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
        exit 1
    fi

    if [ -n "${varValue}" ]; then
        export "$var"="${varValue}"
    elif [ -n "${fileVarValue}" ]; then
        export "$var"="$(cat "${fileVarValue}")"
    elif [ -n "${def}" ]; then
        export "$var"="$def"
    fi

    unset "$fileVar"
}

if [ ! -f "/var/www/html/ipconfig.php" ]; then
    echo "[Entrypoint] Installing InvoicePlane"
    echo

    run_as "cp /var/www/html/ipconfig.php.example /var/www/html/ipconfig.php"

    file_env DB_HOSTNAME
    file_env DB_USERNAME
    file_env DB_PASSWORD
    file_env DB_DATABASE
    file_env DB_PORT

    for key in $(awk 'BEGIN{for(v in ENVIRON) print v}'); do
        val="$(printenv ${key})"
        val=$(echo "${val}" | sed "s/\//\\\\\//g")

        run_as "sed -ir \"s/^[#]*\s*${key}=.*/${key}=${val}/\" /var/www/html/ipconfig.php"
    done

    if [ "${REMOVE_INDEXPHP}" = "true" ]; then
        run_as "cp /var/www/html/htaccess /var/www/html/.htaccess"
    fi
fi

echo "[Entrypoint] Starting application..."
echo

exec "$@"
