class AddRoundsToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :played_rounds, :integer, default: 0
  end
end
