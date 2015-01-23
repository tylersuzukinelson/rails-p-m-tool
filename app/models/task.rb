class Task < ActiveRecord::Base
  belongs_to :project
  validates :title, presence: true
  validates :description, presence: true
  validate :default_completion

  private

  def default_completion
    self.complete ||= false
  end
end
