class CreateGposts < ActiveRecord::Migration[5.1]
  def change
    create_table :gposts do |t|
      t.string :title
      t.text :body
      t.string :link
      t.references :gfolder, foreign_key: true

      t.timestamps
    end
  end
end
