# wait-for-mysql.sh
#!/bin/bash
# Wait for MySQL to be ready
until nc -z -v -w30 mysql 3306; do
  echo "Waiting for MySQL..."
  sleep 5
done
echo "MySQL is up and running"
