class CreateKudos < ActiveRecord::Migration[5.2]
  def change
    create_table :kudos do |t|
      t.references :giver
      t.references :receiver

      t.timestamps
    end
  end
end
