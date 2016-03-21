require 'datatables/directories_datatable.rb'

class DirectoriesController < ApplicationController
  load_and_authorize_resource
  
  # GET /directories
  # GET /directories.json
  def index
    # @directories = (Directory.where('private is null or private is false') + Directory.joins(:owners).where('directory_owners.user_id = ?', current_user.id) + Directory.joins(:allowed_users).where('directory_allowed_users.user_id = ?', current_user.id)).uniq
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => DirectoriesDatatable.new(view_context, current_user)}
    end
  end

  # GET /directories/1
  # GET /directories/1.json
  def show
    @directory = Directory.find(params[:id])

    if params[:allowed_users_json]
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @directory.allowed_users.select('users.id, users.name') }
      end
    elsif params[:owners_json]
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @directory.owners.select('users.id, users.name').where('users.id <> ?', current_user.id) }
      end
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @directory }
      end
    end
  end

  # GET /directories/new
  # GET /directories/new.json
  def new
    @directory = Directory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @directory }
    end
  end

  # GET /directories/1/edit
  def edit
    @directory = Directory.find(params[:id])
  end

  # POST /directories
  # POST /directories.json
  def create
    @directory = Directory.new(params[:directory])
    @directory.original_owner_id = current_user.id
    
    @directory.allowed_user_ids = params[:directory][:allowed_user_ids].first.split(',') unless params[:directory][:allowed_user_ids].blank?
    @directory.owner_ids = params[:directory][:owner_ids].first.split(',') unless params[:directory][:owner_ids].blank?

    respond_to do |format|
      if @directory.save
        format.html { redirect_to @directory, notice: t('general.notices.directory.directory_was_successfully_created') }
        format.json { render json: @directory, status: :created, location: @directory }
      else
        format.html { render action: "new" }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /directories/1
  # PUT /directories/1.json
  def update
    @directory = Directory.find(params[:id])
    params[:directory][:allowed_user_ids] = params[:directory][:allowed_user_ids].first.split(',')
    params[:directory][:owner_ids] = params[:directory][:owner_ids].first.split(',')
    
    respond_to do |format|
      if @directory.update_attributes(params[:directory])
        format.html { redirect_to @directory, notice: t('general.notices.directory.directory_was_successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directories/1
  # DELETE /directories/1.json
  def destroy
    @directory = Directory.find(params[:id])
    begin
      @directory.destroy
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = 'Dependencia restrita'
      respond_to do |format|
        format.html { redirect_to @directory }
        format.json { head :no_content }
      end

    else
      respond_to do |format|
        format.html { redirect_to directories_url }
        format.json { head :no_content }
      end
    end
  end

  def compress_and_download
    directory = Directory.find(params[:directory_id])
    system "mkdir tmp/#{directory.id}"
    directory.su_files.each do |file|
      system "cp #{file.upload.path} tmp/#{directory.id}"
    end
    zip_file_name = "#{directory.title.parameterize}.zip"
    zip_file = system "zip -r tmp/#{zip_file_name} tmp/#{directory.id}" 
    zip_file_path = "tmp/#{zip_file_name}"
    File.open(zip_file_path, 'r') do |f|
      send_data f.read, type: "application/zip"
    end
    File.delete(zip_file_path)
    system "rm -rf tmp/#{directory.id}"
  end
end
