class ChangeBookFieldsToNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :books, :title, false
    change_column_null :books, :author, false
    change_column_null :books, :publisher, false
    change_column_null :books, :genre, false
    change_column_null :books, :language, false
    change_column_null :books, :edition, false
    change_column_null :books, :place, false
    change_column_null :books, :year, false
  end
end
