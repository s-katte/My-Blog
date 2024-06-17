class CreateBlogs < ActiveRecord::Migration[7.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.string :status
      t.datetime :published_date

      t.timestamps
    end
  end
end
