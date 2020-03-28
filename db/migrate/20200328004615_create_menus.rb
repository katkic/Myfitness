class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false, default: ''
      t.string :interval, null: false, default: 2

      t.timestamps
    end
  end
end
