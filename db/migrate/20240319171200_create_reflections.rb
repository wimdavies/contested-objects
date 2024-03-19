class CreateReflections < ActiveRecord::Migration[7.1]
  def change
    create_table :reflections do |t|
      t.boolean :deaccession_flag
      t.text :deaccession_reason
      t.text :provenance_thoughts
      t.text :presence_feelings
      t.text :absence_feelings

      t.timestamps
    end
  end
end
