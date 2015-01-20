class Task < ActiveRecord::Base
  validates :title, presence: true
  validate :default_completion

  private

  def default_completion
    self.completed ||= false
  end
end
