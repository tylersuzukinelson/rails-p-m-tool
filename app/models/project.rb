class Project < ActiveRecord::Base
  belongs_to :user
  has_many :discussions, dependent: :nullify
  has_many :tasks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :user_favorites, through: :favorites, source: :user
  has_many :tags, dependent: :destroy
  has_many :user_tags, through: :tags, source: :user
  has_many :members, dependent: :destroy
  has_many :project_members, through: :members, source: :user
  validates :title, presence: true, uniqueness: true

end
