class AddProjectsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :project_id, :integer, index: true
    add_foreign_key :tasks, :projects
  end
end
