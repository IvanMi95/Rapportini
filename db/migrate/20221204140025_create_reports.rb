class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.text :description
      t.string :material
      t.float :hours

      t.timestamps
    end
  end
end
