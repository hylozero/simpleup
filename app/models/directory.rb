class Directory < ActiveRecord::Base
  attr_accessible :description, :owner_id, :title, :private, :allowed_user_ids, :su_files

  has_many :su_files, dependent: :restrict
    
  has_many :owners, class_name: 'User', through: :directory_owners
  has_many :directory_owners, dependent: :destroy
  
  has_many :allowed_users, class_name: 'User', through: :directory_allowed_users
  has_many :directory_allowed_users, dependent: :destroy
  
  validates_presence_of :title
  validates_presence_of :allowed_users, if: lambda{|d| d.private == true}
end
