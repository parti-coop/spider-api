class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url, length: 1000, null: false, index: true, unique: true
      t.string :image
      t.string :type
      t.string :description
      t.string :site_name
      t.text :source
      t.string :loading_status, null: false
      t.timestamps null: false
    end
  end
end