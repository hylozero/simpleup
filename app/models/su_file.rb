class SuFile < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :upload, :directory_id, :description
  
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

  before_create :set_description
  
  def set_description
    if self.description.blank?
      self.description =  self.upload_file_name
    end
  end

  def define_description
    if self.description.blank?
      return self.upload_file_name
    else
      return self.description
    end
  end

  def define_thumb
    file_type = self.upload_content_type.split('/')
    if file_type[0] == 'application'
      case file_type[1]
      when 'pdf'
        return "fa fa-file-pdf-o"
      when 'zip'
        return "fa fa-file-zip-o"
      end
    else
      return "fa fa-file-photo-o"
    end
  end
    
  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "description" => define_description,
      "url" => upload.url(:original),
      "thumbnail_url" => define_thumb,
      "delete_url" => directory_su_file_path(self.directory, self),
      "delete_type" => "DELETE" 
    }
  end
end
