class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.string :name, null: false, default: ''
      t.integer :part, null: false, default: 0
      t.integer :category, null: false, default: 0
      t.text :description, null: false, default: ''
      t.string :icon
      t.boolean :preset, null: false, default: false

      t.timestamps
    end
  end
end
