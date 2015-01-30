class Member < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :project, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true
end
