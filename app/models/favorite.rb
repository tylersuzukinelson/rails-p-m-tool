class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user, presence: true
  validates :project, presence: true, uniqueness: { scope: :user }
  validate :is_own_project

  private

  def is_own_project
    if user.projects.include? project
      errors.add(:project, "is owned by you! You can't favorite your own projects!")
    end
  end
end
