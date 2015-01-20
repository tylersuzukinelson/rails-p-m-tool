class Task < ActiveRecord::Base
  validates :title, presence: true
  validate :default_completion

  private

  def default_completion
    self.complete ||= false
  end
end
