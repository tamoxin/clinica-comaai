class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :userType
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :phone
      t.boolean :active

      t.timestamps
    end
  end
end
