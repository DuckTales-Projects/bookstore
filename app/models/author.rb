# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :publishers, through: :books

  validates :name, presence: true, length: { in: 3..20 }
end
