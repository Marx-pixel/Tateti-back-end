class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :board, foreign_key: true
      t.string :nombre

      t.timestamps
    end
  end
end
