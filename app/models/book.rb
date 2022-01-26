# frozen_string_literal:true

class Book < ApplicationRecord
  enum language: {
    portuguese: 0,
    english: 1,
    spanish: 2
  }
  validates :title,
            :author,
            :publisher,
            :genre,
            :language,
            :edition,
            :place,
            :year, presence: true
end
