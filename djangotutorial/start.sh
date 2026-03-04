#! /usr/bin/bash

set -e # Exit on any error

# Make sure the data directory exists. This silences an ugly error but isn't
# strictly necessary.
mkdir -p $DATA_DIR

if ! python3 manage.py migrate --check; then
    echo "Applying Django database migrations..."
    python3 manage.py migrate
    python3 manage.py createsuperuser --noinput \
        --username $DJANGO_SUPERUSER_USERNAME \
        --email $DJANGO_SUPERUSER_EMAIL
else
    echo "Database is up to date. No migrations needed."
fi

python3 manage.py runserver 0.0.0.0:$PORT