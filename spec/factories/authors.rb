# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { Faker::Artist.name }
  end
end
