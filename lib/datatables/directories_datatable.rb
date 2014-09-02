# encoding: utf-8

class DirectoriesDatatable
  delegate :params, :h, :link_to, :l, :private_visibility_labeling, :directory_su_files_path, :edit_directory_path, :directory_path, :i, :can?, :to => :@view

  def initialize(view, current_user)
    @view = view
    @current_user = current_user
  end

  def as_json(options = {})
    {
      :sEcho => params[:sEcho].to_i,
      :iTotalRecords => Directory.count,
      :iTotalDisplayRecords => directories.count,
      :aaData => data
    }
  end

  private

  def data
    directories.map do |d|
        [ 
        (link_to d.title, d),
        private_visibility_labeling(d.private), 
        d.created_at,
        "#{link_to i('icon-file'), directory_su_files_path(d), :class => 'btn btn-mini', :"data-placement" => 'top', :"data-toggle" => 'tooltip', :"data-original-title" => I18n.t('activerecord.models.su_file').pluralize, :rel => 'tooltip'} 
         #{link_to i('icon-pencil'), edit_directory_path(d), :class => 'btn btn-mini'}
         #{link_to i('icon-trash'), directory_path(d), :method => :delete, :data => { :confirm => I18n.t('.confirm', :default => I18n.t('helpers.links.confirm', :default => 'Are you sure?')) }, :class => 'btn btn-mini btn-danger'}"
        ]
    end
  end    

  def directories
    @directories ||= fetch_directories
  end

  def fetch_directories
    directories = Directory
      .joins("LEFT JOIN \"directory_owners\" ON \"directory_owners\".\"directory_id\" = \"directories\".\"id\" LEFT JOIN \"directory_allowed_users\" ON \"directory_allowed_users\".\"directory_id\" = \"directories\".\"id\"")
      .where('(directory_owners.user_id = ? or directory_allowed_users.user_id = ?) or directories.private is null or directories.private is false', @current_user.id, @current_user.id)
    if params[:sSearch].present?
      directories = Directory
        .joins("LEFT JOIN \"directory_owners\" ON \"directory_owners\".\"directory_id\" = \"directories\".\"id\" LEFT JOIN \"directory_allowed_users\" ON \"directory_allowed_users\".\"directory_id\" = \"directories\".\"id\"")
        .where('directory_owners.user_id = ? or directory_allowed_users.user_id = ? or directories.private is null or directories.private is false', @current_user.id, @current_user.id)
        .where('(TRANSLATE(lower(directories.title), \'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ\', \'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC\')) like ?', "%#{params[:sSearch].downcase}%")
        .order("#{sort_column} #{sort_direction}")
    end
    directories = directories.page(page).per_page(per_page)      
    directories
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[title private created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
