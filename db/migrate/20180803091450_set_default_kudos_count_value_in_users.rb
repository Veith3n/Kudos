class SetDefaultKudosCountValueInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :kudos_count, :integer, default: 0
  end
end
