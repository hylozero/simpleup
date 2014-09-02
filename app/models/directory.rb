class Directory < ActiveRecord::Base
  attr_accessible :description, :owner_id, :title, :private, :allowed_user_ids, :owner_ids, :su_files

  has_many :su_files, dependent: :restrict
    
  has_many :owners, class_name: 'User', through: :directory_owners
  has_many :directory_owners, dependent: :destroy
  
  has_many :allowed_users, class_name: 'User', through: :directory_allowed_users
  has_many :directory_allowed_users, dependent: :destroy
  
  belongs_to :original_owner, class_name: 'User', foreign_key: 'original_owner_id'

  validates_presence_of :title
  validates_presence_of :allowed_user_ids, if: lambda{|d| d.private == true}
  
  before_update :destroy_allowed_users_if_public
  
  def destroy_allowed_users_if_public
    if self.private == false or self.private.nil?
      self.allowed_users.destroy_all
    end
  end
end
