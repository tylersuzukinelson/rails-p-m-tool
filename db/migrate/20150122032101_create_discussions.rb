class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.text :body
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :discussions, :projects
  end
end
