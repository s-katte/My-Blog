class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :blog, null: false, foreign_key: true
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end