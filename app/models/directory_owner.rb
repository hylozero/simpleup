class DirectoryOwner < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  belongs_to :directory
  # attr_accessible :title, :body
end
