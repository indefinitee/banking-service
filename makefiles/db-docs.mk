.PHONY: db_docs db_schema

db_docs:
	dbdocs build doc/db.dbml

db_schema: 
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml