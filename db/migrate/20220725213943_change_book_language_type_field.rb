class ChangeBookLanguageTypeField < ActiveRecord::Migration[7.1]
  def change
    change_column :books, :language, :string
  end
end
