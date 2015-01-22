class Project < ActiveRecord::Base
  has_many :discussions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  validates :title, presence: true
end
