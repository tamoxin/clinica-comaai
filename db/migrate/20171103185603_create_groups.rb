class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :code
      t.string :name
      t.string :description
      t.date :startDate
      t.date :endDate
      t.boolean :active
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
