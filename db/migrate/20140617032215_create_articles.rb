class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content, null: true
      t.integer :type, limit: 1
      t.integer :status, limit: 1
      t.timestamps
    end
  end
end
