class AddCapacityToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :capacity, :integer
  end
end
