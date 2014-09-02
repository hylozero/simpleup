class SuFile < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :upload, :directory_id
  
  # S3 Storage config
  # has_attached_file :upload,
  #                   :storage => :s3,
  #                   :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
  # 
  # def s3_credentials
  #   {:bucket => "xxx", :access_key_id => "xxx", :secret_access_key => "xxx"}
  # end

  has_attached_file :upload
                  
  belongs_to :directory
  do_not_validate_attachment_file_type :upload
    
  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => directory_su_file_path(self.directory, self),
      "delete_type" => "DELETE" 
    }
  end
end
