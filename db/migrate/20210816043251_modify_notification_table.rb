class ModifyNotificationTable < ActiveRecord::Migration[6.1]
  def change
    change_column :notifications, :type, :string, :null => true
  end
end
