class AddNameToMuseumObject < ActiveRecord::Migration[7.1]
  def change
    add_column :museum_objects, :name, :string
  end
end
