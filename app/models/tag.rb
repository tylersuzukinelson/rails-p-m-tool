class Tag < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :title, presence: true
  validate :no_spaces

  private

  def no_spaces
    self.title.gsub!(/ /, '_')
  end
end
