class Directory < ActiveRecord::Base
  attr_accessible :description, :owner_id, :title

  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :su_files
end
