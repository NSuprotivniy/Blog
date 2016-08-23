  # Blog
---
Ruby on Rails blog example which works on redactor-rails and pg_search gems.

---
## All you need to run it on your machine.

#### Install PostgreSQL
[postgresql.org/download/](https://www.postgresql.org/download/)

#### Change `config/database.yml`

White your user name and database name in.


``` yaml
development:
  <<: *default
  database: Blog_development
  username: user_name

test:
  <<: *default
  database: Blog_test
  username: user_name

```
Use command if you do not know user name of your Postgres base:

` $ psql postgres -c '\du'`
