# CSE 3153 Group 5: Project Parts 2 & 3

Run the SQL in `part2-sql/` in order: `01-create-tables.sql`, `02-insert-data.sql`, `03-queries.sql`.

| Folder / file | What | Owner |
|---|---|---|
| `part2-sql/01-create-tables.sql`, `02-insert-data.sql` | Tables and sample data | Riley |
| `part2-sql/03-queries.sql`, Queries 1–2 | Customers and purchases; products under $500 | Douglas |
| `part2-sql/03-queries.sql`, Queries 3, 6 | Offerings and products; oldest service | Ayman |
| `part2-sql/03-queries.sql`, Queries 4–5 | Services per customer; most expensive service | Jacob |
| `part3-webapp/` | ASP.NET pages for Customer, Product, Purchase | Richard |
| `docs/` | Division of labor; Richard's screenshots doc | |

Each query in `03-queries.sql` has a `-- Query N (Name)` header. To see one person's work: `git log --author=<github name>` or `git blame part2-sql/03-queries.sql`.

`part3-webapp/Web.config` connects to `(localdb)\MSSQLLocalDB`, database `Project`. Change the server if yours differs.
