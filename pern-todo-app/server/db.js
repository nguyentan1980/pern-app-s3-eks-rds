const Pool = require('pg').Pool;

require('dotenv').config();

const pool = new Pool({  
  connectionString: 'postgresql://postgres:HwLjy7vJ7l80DESr@exam-perntodo-ethan-env.cba6rpvi5fmd.us-east-1.rds.amazonaws.com:5432/perntodo',
});

module.exports = pool;
