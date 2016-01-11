class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url, length: 1000, null: false, index: true, unique: true
      t.text :title
      t.string :image
      t.string :page_type
      t.text :description
      t.text :metadata
      t.string :loading_status, null: false
      t.timestamps null: false
    end
  end
end
