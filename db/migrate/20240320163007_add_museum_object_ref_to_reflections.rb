class AddMuseumObjectRefToReflections < ActiveRecord::Migration[7.1]
  def change
    add_reference :reflections, :museum_object, null: false, foreign_key: true
  end
end
