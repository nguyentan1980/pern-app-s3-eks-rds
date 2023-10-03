dburl=$(grep connectionString db.js | awk '{print $2}' | sed 's/,//g' | sed "s/'//g")
psql $dburl -c 'CREATE TABLE IF NOT EXISTS todo(todo_id SERIAL PRIMARY KEY,description VARCHAR(255));'

