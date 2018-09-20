class AddAmounToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :amount, :integer, default: 1
  end
end
