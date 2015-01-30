class Tag < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user, presence: true
  validates :project, presence: true
  validate :no_spaces
  validates :title, presence: true, uniqueness: { scope: :project }

  private

  def no_spaces
    self.title.gsub!(/ /, '_')
  end
end
