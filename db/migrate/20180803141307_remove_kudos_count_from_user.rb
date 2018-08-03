class RemoveKudosCountFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :kudos_count
  end
end
