const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'openbravo',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || '',
});

async function testConnection() {
  console.log('🔍 Testing database connection...');
  console.log('Configuration:');
  console.log(`  Host: ${process.env.DB_HOST}`);
  console.log(`  Port: ${process.env.DB_PORT}`);
  console.log(`  Database: ${process.env.DB_NAME}`);
  console.log(`  User: ${process.env.DB_USER}`);
  console.log('');

  try {
    const client = await pool.connect();
    console.log('✅ Database connection successful!');
    
    // Test query
    const result = await client.query('SELECT NOW() as current_time');
    console.log('✅ Test query successful!');
    console.log(`   Current time: ${result.rows[0].current_time}`);
    
    // Test tables
    console.log('\n🔍 Checking required tables...');
    const tables = [
      'robprj_orab',
      'c_order',
      'c_project',
      'c_uom',
      'robprj_parealisasi',
      'robprj_projectactivity'
    ];
    
    for (const table of tables) {
      const checkTable = await client.query(
        `SELECT EXISTS (
          SELECT FROM information_schema.tables 
          WHERE table_name = $1
        )`,
        [table]
      );
      
      if (checkTable.rows[0].exists) {
        console.log(`   ✅ ${table}`);
      } else {
        console.log(`   ❌ ${table} - TABLE NOT FOUND!`);
      }
    }
    
    client.release();
    console.log('\n✅ All checks completed!');
    process.exit(0);
  } catch (error) {
    console.error('❌ Database connection failed!');
    console.error('Error:', error.message);
    process.exit(1);
  }
}

testConnection();
