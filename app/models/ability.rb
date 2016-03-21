class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin
      can :manage, :all
    else
      can [:compress_and_download, :read], Directory do |directory|
        directory.private.nil? or directory.private == false or directory.owners.map {|u| u.id}.include?(user.id) or directory.allowed_users.map {|u| u.id}.include?(user.id) or directory.original_owner_id == user.id
      end

      can :create, Directory
      can [:update, :destroy], Directory do |directory|
        directory.owners.map {|u| u.id}.include?(user.id) or directory.original_owner_id == user.id
      end

      can [:read, :download], SuFile do |su_file|
        su_file.directory.owners.map {|u| u.id}.include?(user.id) or su_file.directory.allowed_users.map {|u| u.id}.include?(user.id)
      end  

      can [:create, :destroy], SuFile do |su_file|
        su_file.directory.owners.map {|u| u.id}.include?(user.id) or su_file.directory.original_owner_id == user.id
      end  
    end
  end
end
