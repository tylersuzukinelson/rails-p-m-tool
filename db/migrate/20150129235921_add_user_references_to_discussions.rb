class AddUserReferencesToDiscussions < ActiveRecord::Migration
  def change
    add_reference :discussions, :user, index: true
    add_foreign_key :discussions, :users
  end
end
