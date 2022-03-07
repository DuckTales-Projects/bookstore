# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { association :author }
    publisher { association :publisher }
    genre { Faker::Book.genre }
    language { %w[portuguese english spanish].sample }
    edition { ['first edition', 'second edition', 'third edition'].sample }
    place { Faker::Nation.nationality }
    year { Faker::Number.within(range: 1900..Time.zone.now.year) }
  end
end
