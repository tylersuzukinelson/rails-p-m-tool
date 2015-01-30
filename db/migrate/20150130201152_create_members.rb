class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :members, :projects
    add_foreign_key :members, :users
  end
end
