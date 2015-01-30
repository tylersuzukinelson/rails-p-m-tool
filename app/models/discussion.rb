class Discussion < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
end
