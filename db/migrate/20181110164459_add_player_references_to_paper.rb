class AddPlayerReferencesToPaper < ActiveRecord::Migration[5.2]
  def change
    add_reference :papers, :player, foreign_key: true
  end
end
