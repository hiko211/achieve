class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
    t.string :title
    t.text :content
    t.timestamps null: false
    t.string :name
    end
  end
end