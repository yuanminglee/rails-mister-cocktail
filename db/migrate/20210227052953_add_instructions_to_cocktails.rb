class AddInstructionsToCocktails < ActiveRecord::Migration[6.1]
  def change
    add_column :cocktails, :instructions, :text
  end
end
