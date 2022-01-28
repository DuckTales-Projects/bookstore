class RemoveUselessColumnsFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :author, :string
    remove_column :books, :publisher, :string
  end
end
