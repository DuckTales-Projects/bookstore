class ChangePublisherNameFieldToNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :publishers, :name, false
  end
end
