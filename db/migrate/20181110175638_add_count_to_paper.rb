class AddCountToPaper < ActiveRecord::Migration[5.2]
  def change
    add_column :papers, :count, :integer, default: 3
  end
end
