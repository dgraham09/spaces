class AddUserReferenceToSpace < ActiveRecord::Migration[7.0]
  def change
    add_reference :spaces, :user, null: false, foreign_key: true
  end
end
