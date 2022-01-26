class ChangeAuthorNameFieldToNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :authors, :name, false
  end
end
