# frozen_string_literal:true

class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher

  validates :year, numericality: { in: 1500..Date.current.year }
  validates :year, :language, presence: true
  validates :title,
            :genre,
            :edition,
            :place, presence: true, length: { in: 2..50 }
end
