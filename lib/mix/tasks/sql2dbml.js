const fs = require('fs');
const { importer } = require('@dbml/core');

// read PostgreSQL file script
const [input, output, dialect = 'postgres'] = process.argv.slice(2);
const SQLcode = fs.readFileSync(`./dbml/${input}.sql`, 'utf-8');

// generate DBML from PostgreSQL script
const dbml = importer.import(SQLcode, dialect);

fs.writeFile(`./dbml/${output}.dbml`, dbml, ['utf-8'], () =>
  console.log(`Check the file ${output}.sql`)
);
