class UsersController < ApplicationController
  def index
    if params[:q]
       @users = User.select("users.id, users.name").from("users").where("(TRANSLATE(lower(users.name), 'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ', 'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC') like '%#{params[:q].downcase}%' and users.id <> ?)", current_user.id)     
       @paginated_users = @users.paginate(:page => params[:page], :per_page => params[:page_limit])
    end

     respond_to do |format|  
         format.html
         format.json { 
           render :json => {
             :users => @paginated_users,
             :total => @paginated_users.count,
             :links => { :self => @paginated_users.current_page , :next => @paginated_users.next_page}
         } 
       }
     end      
  end
end