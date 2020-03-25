class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true, null: false
      t.float :height
      t.string :icon
      t.string :headdre_image
      t.boolean :public_flag, null: false, default: true

      t.timestamps
    end
  end
end
