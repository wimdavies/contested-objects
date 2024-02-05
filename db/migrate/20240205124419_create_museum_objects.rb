class CreateMuseumObjects < ActiveRecord::Migration[7.1]
  def change
    create_table :museum_objects do |t|
      t.string :system_number

      t.timestamps
    end
  end
end
