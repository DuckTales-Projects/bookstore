# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author
    publisher
    genre { Faker::Book.genre }
    language { Faker::Nation.language }
    edition { ['first edition', 'second edition', 'third edition'].sample }
    place { Faker::Nation.nationality }
    year { Faker::Number.within(range: 1900..Date.current.year) }
  end
end
