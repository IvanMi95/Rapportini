class AddClientToReport < ActiveRecord::Migration[7.0]
  def change
    add_reference :reports, :client, null: false, foreign_key: true
  end
end
