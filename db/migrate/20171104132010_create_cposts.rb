class CreateCposts < ActiveRecord::Migration[5.1]
  def change
    create_table :cposts do |t|
      t.string :title
      t.text :body
      t.string :link
      t.references :cfolder, foreign_key: true

      t.timestamps
    end
  end
end
