class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :date
      t.string :location
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
