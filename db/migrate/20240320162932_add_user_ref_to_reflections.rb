class AddUserRefToReflections < ActiveRecord::Migration[7.1]
  def change
    add_reference :reflections, :user, null: false, foreign_key: true
  end
end
