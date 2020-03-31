class CreateExerciseLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :exercise_logs do |t|
      t.references :workout, foreign_key: true, null: false
      t.integer :set, null: false
      t.float :weight, null: false
      t.integer :rep, null: false

      t.timestamps
    end
  end
end
