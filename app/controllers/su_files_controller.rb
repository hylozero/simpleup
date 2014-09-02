class SuFilesController < ApplicationController
  load_and_authorize_resource :directory
  load_and_authorize_resource :su_file, :through => :directory
  
  def index
    @directory = Directory.find(params[:directory_id])
    @su_files = @directory.su_files

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @su_files.map{|sf| sf.to_jq_upload } }
    end
  end
  
  def download
    su_file = SuFile.find_by_upload_file_name(params[:file_name])
    if File.exist?(path = su_file.upload.path)
      send_file path, content_type: su_file.upload_content_type
    end
  end

  def create
    @su_file = SuFile.new(params[:su_file])
    @su_file.directory_id = params[:directory_id]

    respond_to do |format|
      if @su_file.save
        format.html {
          render :json => [@su_file.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@su_file.to_jq_upload]}, status: :created, location: directory_su_file_path(@su_file.directory, @su_file) }
      else
        format.html { render action: "new" }
        format.json { render json: @su_file.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @su_file = SuFile.find(params[:id])
    @su_file.destroy

    respond_to do |format|
      format.html { redirect_to directory_su_file_path(@su_file.directory, @su_file) }
      format.json { head :no_content }
    end
  end
end
