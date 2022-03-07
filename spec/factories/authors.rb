# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { Faker::Name.middle_name }
  end
end
