# frozen_string_literal:true

class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher

  validates :title,
            :genre,
            :language,
            :edition,
            :place,
            :year, presence: true

  enum language: {
    portuguese: 0,
    english: 1,
    spanish: 2
  }
end
