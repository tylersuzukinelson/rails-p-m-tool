class Project < ActiveRecord::Base
  belongs_to :user
  has_many :discussions, dependent: :nullify
  has_many :tasks, dependent: :destroy
  validates :title, presence: true
end
