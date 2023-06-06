class AddUsersToComments < ActiveRecord::Migration[7.0]
  def change
    # To generate foreign key by adding posts as table name, user as reference table, and setting null to false
    # Note: user is not pluralized because add_reference will automatically pluralize the table name when creating the foreign key.
    add_reference :comments, :user, null: false, foreign_key: true
  end
end
