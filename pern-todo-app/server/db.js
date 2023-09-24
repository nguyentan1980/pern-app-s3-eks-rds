const Pool = require('pg').Pool;

require('dotenv').config();

const pool = new Pool({  
  connectionString: 'postgresql',
});

module.exports = pool;
