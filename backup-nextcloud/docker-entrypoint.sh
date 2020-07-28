#!/bin/sh

set -e

log() {
  echo "[Entrypoint] ${1}"
  return 0
}

if [ -z "${BACKUP_ROTATIONS}" ]; then
  export BACKUP_ROTATIONS=4
fi

if [ "$1" = "cron" ] && [ -z "${CRON_PERIOD}" ]; then
  log "\$CRON_PERIOD must be set. Exiting"
  exit 1
fi

log "Setup environment..."
echo
log "   NEXTCLOUD_VOLUME = ${NEXTCLOUD_VOLUME}"
log "   BACKUP_ROTATIONS = ${BACKUP_ROTATIONS}"

if [ "$1" = "cron" ]; then
  log "        CRON_PERIOD = ${CRON_PERIOD}"
  echo

  log "Initialize backup service....."
  log "Installing cron: ${CRON_PERIOD}"

  # create backup-cron file...
  echo "${CRON_PERIOD} /usr/bin/flock -n /tmp/backup.lockfile /usr/local/bin/backup > /proc/1/fd/1" > /etc/cron.d/backup
  chmod 600 /etc/cron.d/backup
  crontab /etc/cron.d/backup

  log "Initialize backup service completed."
  log "Starting cron...."
  echo

  # Run cron.....
  exec crond -n
fi

if [ "$1" = "backup" ]; then
  echo
  log "Starting backup...."
  echo
  exec env BACKUP_ROTATIONS=${BACKUP_ROTATIONS} /usr/bin/flock -n /tmp/backup.lockfile /usr/local/bin/backup
fi

exit 0
