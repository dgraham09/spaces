class AddRatingtoSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :rating, :string
  end
end
