# BookStore

[![codecov](https://codecov.io/gh/DuckTales-Projects/bookstore/branch/development/graph/badge.svg?token=PAKYJ5B96U)](https://codecov.io/gh/DuckTales-Projects/bookstore) [![codebeat badge](https://codebeat.co/badges/f6515d51-80f0-4f6e-bcea-490713045d6a)](https://codebeat.co/projects/github-com-ducktales-projects-bookstore-development)  ![code_analizers](https://github.com/DuckTales-Projects/bookstore/actions/workflows/code_analyzers.yml/badge.svg)

The objective of this project is to test my knowledge, it is an API where it is possible to register and consult a list of books, authors and publishers.

## System dependencies

```markdown
* Ruby version      - version 3.1.0
* Rails version     - version 7.1.0.alpha
* RSpec version     - version 3.11.0.pre
* Rubocop version   - version 1.24.1
```

## Usage

Install and configure the database: [PostgreSQL](https://www.postgresql.org/)

if you have docker configured and installed, you can use this alias to upload its image:

```sh
alias postgres_up='docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres'
```

clone this project:

```sh
git clone https://github.com/DuckTales-Projects/bookstore.git

cd bookstore

gem install bundler         # => install bundler

bundle install              # => install project dependencies

bin/rails db:create db:migrate   # => prepare the database

bin/rails s                     # => start server

bin/rails c                     # => start console

bundle exec rspec           # => to run the tests
```

start the server and access the url: <http://localhost:3000>

## future updates

```markdown
- the api will be able to listen for http calls, process and return a json
```
