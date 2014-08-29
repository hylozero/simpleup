class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin
      can :manage, all
    else
      can :read, Directory do |directory|
        directory.private.nil? or directory.private == false or directory.owners.map {|u| u.id}.include?(user.id) or directory.allowed_users.map {|u| u.id}.include?(user.id)
      end
      can :create, Directory
      can [:edit, :destroy], Directory do |directory|
        directory.owners.map {|u| u.id}.include?(user.id)
      end
    end
  end
end
