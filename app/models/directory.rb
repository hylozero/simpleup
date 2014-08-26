class Directory < ActiveRecord::Base
  attr_accessible :description, :owner_id, :title

  has_many :su_files, dependent: :restrict
  
  has_many :owners, class_name: 'User', through: :directory_owners
  has_many :directory_owners, dependent: :destroy
end
