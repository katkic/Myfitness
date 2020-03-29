class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.references :user, foreign_key: true
      t.references :exercise, foreign_key: true
      t.integer :condition, null: false, default: 3
      t.text :memo, null: false, default: ''

      t.timestamps
    end
  end
end
