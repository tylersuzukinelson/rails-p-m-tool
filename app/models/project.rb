class Project < ActiveRecord::Base
  has_many :discussions, dependent: :destroy
  validates :title, presence: true
end
