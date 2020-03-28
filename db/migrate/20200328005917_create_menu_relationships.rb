class CreateMenuRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_relationships do |t|
      t.references :menu, foreign_key: true, null: false
      t.references :exercise, foreign_key: true, null: false

      t.timestamps
    end
  end
end
