# BookStore

[![codecov](https://codecov.io/gh/DuckTales-Projects/bookstore/branch/development/graph/badge.svg?token=PAKYJ5B96U)](https://codecov.io/gh/DuckTales-Projects/bookstore) [![codebeat badge](https://codebeat.co/badges/f6515d51-80f0-4f6e-bcea-490713045d6a)](https://codebeat.co/projects/github-com-ducktales-projects-bookstore-development)  ![code_analizers](https://github.com/DuckTales-Projects/bookstore/actions/workflows/code_analyzers.yml/badge.svg)

The objective of this project is to test my knowledge, it is an API where it is possible to register and consult a list of books, authors and publishers.

## System dependencies

```text
if you are not going to use docker:
* Ruby 3.1.0
* PostgreSQL
* zsh

if you are going to use docker:
* Docker
* Docker-compose
* zsh
```

## Usage

### If you are not going to use docker:

First install and configure the database ([PostgreSQL](https://www.postgresql.org/)).

```sh
# clone the project
git clone https://github.com/DuckTales-Projects/bookstore.git

cd bookstore           # => enter the projector directory

gem install bundler    # => install bundler

bundle install         # => install gems

bin/rails db:prepare   # => prepare the database

bundle exec rspec      # => to run the tests

bin/rails s            # => to start server

bin/rails c            # => to start console
```

### If you are going to use docker:

With dependencies satisfied, run the following commands:

```sh
git clone https://github.com/DuckTales-Projects/bookstore.git

cd bookstore

zsh script/run   # => to build, run docker images and run the server

zsh script/zsh   # => to run shell in container

# inside the container
be rspec         # => Same as "bundle exec rspec" (run tests)

bin/rails c      # => start console

```

## Accessing the application

Run the server, open the browser and access `http://localhost:3000/`.

You should see the following screen:

<p align="left">
  <img src="https://user-images.githubusercontent.com/60988594/180815904-5c68b7b4-f13f-4438-9737-54f6f4432a13.png" alt="Welcome screen" height="300" width="380"/>
</p>

Access API [documentation](https://github.com/DuckTales-Projects/bookstore/edit/dockerization/README.md#accessing-the-application) to find out how to make requests. (Under construction)
