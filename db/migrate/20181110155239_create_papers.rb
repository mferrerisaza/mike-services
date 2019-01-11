class CreatePapers < ActiveRecord::Migration[5.2]
  def change
    create_table :papers do |t|
      t.string :description
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
