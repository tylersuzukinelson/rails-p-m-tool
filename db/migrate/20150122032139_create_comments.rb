class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :discussion, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :discussions
  end
end
