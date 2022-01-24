# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'MyString' }
    author { 'MyString' }
    publisher { 'MyString' }
    genre { 'MyString' }
    language { 'MyString' }
    edition { 'MyString' }
    place { 'MyString' }
    year { 1 }
  end
end
