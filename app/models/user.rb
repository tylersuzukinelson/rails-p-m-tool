class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments, dependent: :destroy
  has_many :discussions, dependent: :nullify
  has_many :projects, dependent: :nullify
  has_many :tasks, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :favorited_projects, through: :favorites, source: :project
  has_many :tags, dependent: :destroy
  has_many :tagged_projects, through: :tags, source: :project
  has_many :members, dependent: :destroy
  has_many :member_projects, through: :members, source: :project

  def has_favorited?(project)
    favorited_projects.include? project
  end

  def favorite_for(project)
    favorites.where(project_id: project.id).first
  end

  def member_for(project)
    members.where(project_id: project.id).first
  end

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end
end
