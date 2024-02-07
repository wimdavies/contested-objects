class AddUniqueIndexToMuseumObjects < ActiveRecord::Migration[7.1]
  def change
    add_index :museum_objects, :system_number, unique: true
  end
end
