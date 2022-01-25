# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    publisher { Faker::Book.publisher }
    genre { Faker::Book.genre }
    language { %w[portuguese english spanish].sample }
    edition { ['first edition', 'second edition', 'third edition'].sample }
    place { Faker::Nation.nationality }
    year { Faker::Number.within(range: 1900..2022) }
  end
end
