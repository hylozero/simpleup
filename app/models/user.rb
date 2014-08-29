class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :directories, through: :directory_owners
  has_many :directory_owners, dependent: :restrict

  has_many :allowed_directories, class_name: 'Directory', through: :directory_allowed_users
  has_many :directory_allowed_users, dependent: :restrict

  validates_presence_of :name
  attr_accessible :name
end
