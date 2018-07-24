
# Export database

```bash

# ./script database remote_host user password

pg_dump --schema-only --no-privileges ${1} > ${1}.schema
pg_dump --no-privileges --format=c ${1} > ${1}.dump
PGPASSWORD=$4 psql -h $2 -U $3 -c "drop database ${1};"
PGPASSWORD=$4 psql -h $2 -U $3 -c "create database ${1};"
PGPASSWORD=$4 psql -h $2 -U $3 ${1} < ${1}.schema
PGPASSWORD=$4 pg_restore -h $2 -U $3 --no-privileges --jobs=6 --no-security-labels --disable-triggers --data-only --dbname=${1} ${1}.dump
```

# Commands

```
\l: List databases
\c __database__: connect to a database
\dt: list tables
```
