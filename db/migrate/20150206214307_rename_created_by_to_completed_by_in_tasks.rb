class RenameCreatedByToCompletedByInTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :created_by, :completed_by
  end
end
