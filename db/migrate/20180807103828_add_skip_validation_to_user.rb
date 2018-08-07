class AddSkipValidationToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :skip_validation, :boolean, default: false
  end
end
