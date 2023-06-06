class AddUsersToPosts < ActiveRecord::Migration[7.0]
  def change
    # To generate foreign key by adding posts as table name, user as reference table, and setting null to fals
    # Rails can automatically reference a table without adding { to_table: :users }, using: add_reference :posts, :user, null: false, foreign_key: true
    # Since we want to custom name the forein_key column, we need to use { to_table: :users }
    add_reference :posts, :author, null: false, foreign_key: { to_table: :users }
  end
end
