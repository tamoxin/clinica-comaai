class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.string :description
      t.integer :professor_id
      t.boolean :active

      t.timestamps
    end
  end
end
