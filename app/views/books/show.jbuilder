# frozen_string_literal: true

json.title @book.title
json.genre @book.genre
json.language @book.language
json.edition @book.edition
json.place @book.place
json.year @book.year
json.author @book.author.name
json.publisher @book.publisher.name
