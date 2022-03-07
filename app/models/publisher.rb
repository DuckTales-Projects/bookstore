# frozen_string_literal: true

class Publisher < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :authors, through: :books

  validates :name, presence: true, length: { in: 5..40 }
end
