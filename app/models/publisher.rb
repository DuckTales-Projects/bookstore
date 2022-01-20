# frozen_string_literal: true

class Publisher < ApplicationRecord
  validates :name, presence: true
end
