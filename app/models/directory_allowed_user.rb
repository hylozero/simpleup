class DirectoryAllowedUser < ActiveRecord::Base
  belongs_to :allowed_user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :allowed_directory, class_name: 'Directory', foreign_key: 'directory_id'
  # attr_accessible :title, :body
end
