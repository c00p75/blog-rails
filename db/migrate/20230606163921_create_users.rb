class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name    # Creating table users with name column to take varchar
      t.string :photo   # Creating table users with photo column to take varchar
      t.text :bio   # Creating table users with bio column to take varchar
      t.integer :posts_counter    # Creating table users with posts_counter column to take varchar

      t.timestamps    #Adds created_at and updated_at automatically
    end
  end
end
