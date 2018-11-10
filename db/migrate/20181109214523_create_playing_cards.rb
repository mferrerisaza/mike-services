class CreatePlayingCards < ActiveRecord::Migration[5.2]
  def change
    create_table :playing_cards do |t|
      t.string :number
      t.string :category
      t.string :rule

      t.timestamps
    end
  end
end
