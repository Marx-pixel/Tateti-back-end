class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.boolean :xTurn, default: true
      t.boolean :winner, default: false
      t.string :squares
      t.integer :turnNumber, default: 1

      t.timestamps
    end
    
  end 

end