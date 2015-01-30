class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :user, index: true
      t.references :project, index: true
      t.string :title

      t.timestamps null: false
    end
    add_foreign_key :tags, :users
    add_foreign_key :tags, :projects
  end
end
