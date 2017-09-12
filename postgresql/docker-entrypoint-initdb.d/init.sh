echo "------------------------------------------"
echo "Bootstrapping the CKAN databases now ....."
echo "------------------------------------------"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE USER ckan_default WITH PASSWORD 'pass' NOSUPERUSER NOCREATEDB NOCREATEROLE;
  CREATE USER datastore_default WITH PASSWORD 'pass' NOSUPERUSER NOCREATEDB NOCREATEROLE;
EOSQL

createdb -U postgres -e -O ckan_default ckan_test -E utf-8
createdb -U postgres -e -O ckan_default datastore_test -E utf-8

echo "------------------------------------------"
echo "Finished bootstrapping the databasees ...."
echo "------------------------------------------"
