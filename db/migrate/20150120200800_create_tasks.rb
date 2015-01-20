class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.boolean :complete
      t.integer :created_by

      t.timestamps null: false
    end
  end
end
